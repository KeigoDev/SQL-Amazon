-- Create a dedicated schema/database for the project
CREATE SCHEMA AmazonData;

-- Switch to the newly created schema
USE amazondata;

-- View the raw imported dataset
SELECT * FROM amazon;

-- Create a duplicate working table to preserve the original data
CREATE TABLE amazonDU AS
SELECT * FROM amazon;

-- Verify the copied dataset
SELECT * FROM amazonDU;

-- Disable safe update mode to allow bulk updates
SET SQL_SAFE_UPDATES = 0;

-- ==========================================================
-- PRICE DATA CLEANING
-- ==========================================================

-- Create a new numeric column for discounted prices
ALTER TABLE amazonDU
ADD COLUMN discountedPrice DECIMAL(10,2);

-- Remove invalid currency symbols and convert values to decimal format
UPDATE amazonDU
SET discountedPrice =
CAST(REPLACE(REPLACE(discounted_price,'â‚¹',''),'₹','')
AS DECIMAL(10,2));

-- Create a new numeric column for actual prices
ALTER TABLE amazonDU
ADD COLUMN actualPrice DECIMAL(10,2);

-- Clean and convert actual prices into decimal values
UPDATE amazonDU
SET actualPrice =
CAST(REPLACE(REPLACE(actual_price,'â‚¹',''),'₹','')
AS DECIMAL(10,2));

-- Review updated records
SELECT * FROM amazonDU;

-- Remove old text-based price columns
ALTER TABLE amazonDU
DROP COLUMN discounted_price;

ALTER TABLE amazonDU
DROP COLUMN actual_price;

-- ==========================================================
-- DISCOUNT PERCENTAGE STANDARDIZATION
-- ==========================================================

-- Create a new column to store discount values as decimals
ALTER TABLE amazonDU
ADD COLUMN discount_value DECIMAL(5,2);

-- Convert percentage strings (e.g., 25%) into decimal values (0.25)
UPDATE amazonDU
SET discount_value =
CAST(REPLACE(discount_percentage,'%','')
AS DECIMAL(5,2))/100;

-- Rename the column for better readability
ALTER TABLE amazonDU
RENAME COLUMN discount_value TO discountValue;

-- Remove the original percentage column
ALTER TABLE amazonDU
DROP COLUMN discount_percentage;

-- ==========================================================
-- RATING COUNT CLEANING
-- ==========================================================

-- Create a new integer column for rating counts
ALTER TABLE amazonDU
ADD COLUMN ratingCount INT;

-- Remove comma separators and convert text values to integers
UPDATE amazonDU
SET ratingCount =
CAST(REPLACE(rating_count,',','') AS UNSIGNED)
WHERE rating_count IS NOT NULL
AND rating_count <> '';

-- Fill missing rating counts using the rounded dataset average
UPDATE amazonDU
SET ratingCount =
(
    SELECT ROUND(AVG(ratingCount))
    FROM (SELECT * FROM amazonDU) AS t
)
WHERE ratingCount IS NULL;

-- Remove the original rating count column
ALTER TABLE amazonDU
DROP COLUMN rating_count;

-- ==========================================================
-- CATEGORY STANDARDIZATION
-- ==========================================================

-- Consolidate lengthy category names into business-friendly groups
UPDATE amazonDU
SET category =
CASE
    WHEN category LIKE 'Home&Kitchen%' THEN 'Kitchen Accessories'
    WHEN category LIKE 'Electronics%' THEN 'Electronics Accessories'
    WHEN category LIKE 'Computer%' THEN 'Computer Accessories'
    WHEN category LIKE 'Musical%' THEN 'Instrument Accessories'
    WHEN category LIKE 'Car%' THEN 'Vehicle Accessories'
    WHEN category LIKE 'Home%' THEN 'Home Accessories'
    WHEN category LIKE 'Office%' THEN 'Office Accessories'
    WHEN category LIKE 'Health%' THEN 'Health Accessories'
    WHEN category LIKE 'Toys%' THEN 'Toys Accessories'
    ELSE category
END;

-- ==========================================================
-- FEATURE ENGINEERING: REVENUE CALCULATION
-- ==========================================================

-- Create a calculated revenue metric
ALTER TABLE amazonDU
ADD COLUMN Revenue DECIMAL(10,2);

-- Estimate revenue using:
-- Revenue = Discounted Price × Number of Ratings
UPDATE amazonDU
SET Revenue = discountedPrice * ratingCount
WHERE Revenue IS NULL OR Revenue = '';

-- Replace blank rating counts with zero
UPDATE amazonDU
SET ratingCount = 0
WHERE ratingCount = '';

-- Convert Revenue to BIGINT to accommodate larger values
ALTER TABLE amazonDU
MODIFY COLUMN Revenue BIGINT;

-- Review final cleaned dataset
SELECT * FROM amazonDU;

-- ==========================================================
-- BUSINESS ANALYSIS QUESTIONS
-- ==========================================================

-- Question 1:
-- Which categories/products generate the highest estimated revenue?
SELECT
    category,
    SUM(discountedPrice - ratingCount) AS TotalRevenue,
    AVG(rating) AS AvgRating
FROM amazonDU
GROUP BY category
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Question 2:
-- Which categories have the lowest customer ratings and may require quality improvements?
SELECT
    category,
    MIN(rating) AS LowestQuality
FROM amazonDU
GROUP BY category
ORDER BY LowestQuality ASC
LIMIT 3;

-- Question 3:
-- Which products have strong ratings but lower visibility,
-- making them suitable candidates for advertising campaigns?
SELECT
    category,
    rating,
    ratingCount
FROM amazonDU
WHERE rating >= 4.0
AND ratingCount < 10000
ORDER BY ratingCount;

-- Question 4:
-- Which categories show weaker customer engagement and may indicate pain points?
SELECT
    category,
    MIN(ratingCount) AS PainPoints
FROM amazonDU
GROUP BY category
ORDER BY PainPoints DESC;

-- Question 5:
-- Can customer ratings, review volume, category information,
-- discounts, and revenue metrics be used to support a future
-- AI-powered recommendation engine?