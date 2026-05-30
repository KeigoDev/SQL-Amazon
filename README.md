# Amazon Product Insights & Customer Experience Optimization Project

## Dataset

https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset

## Tableau Public Dashboard 

https://public.tableau.com/views/AmazonInsights_17589781396940/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

## Overview

This project analyzes Amazon product ratings and review data to uncover insights that support business growth, customer satisfaction, and data-driven decision-making. Using SQL for data cleaning and transformation and Tableau for visualization, the project identifies high-performing product categories, quality improvement opportunities, marketing candidates, and customer engagement trends.

The analysis demonstrates how customer feedback can be transformed into actionable business intelligence and provides a foundation for future AI-powered recommendation systems.

---

## Business Problem

Amazon receives millions of customer reviews and ratings across its marketplace. While this data contains valuable insights, organizations often struggle to convert raw customer feedback into actionable strategies.

This project aims to answer the following business questions:

1. Which categories/products generate the highest revenue potential?
2. Which categories require quality improvements?
3. Which products should be prioritized for marketing campaigns?
4. What customer engagement trends can reveal potential pain points?
5. Can review data support a future recommendation engine?

---

## Dataset

**Source:** Amazon Product Ratings & Reviews Dataset

### Dataset Characteristics

* 1,464 records
* Product information
* Ratings and rating counts
* Product categories
* Discount percentages
* Actual and discounted prices
* Customer review metrics

---

## Tools & Technologies

* **SQL (MySQL)** – Data cleaning, transformation, and business analysis
* **Tableau** – Dashboard development and visualization
* **Excel/CSV** – Dataset source and validation

---

## Data Cleaning & Preparation

The raw dataset required multiple preprocessing steps before analysis.

### Data Cleaning Activities

#### Price Standardization

* Removed invalid currency symbols (`â‚¹`, `₹`)
* Converted text-based prices into numeric decimal values
* Created:

  * `discountedPrice`
  * `actualPrice`

#### Discount Percentage Transformation

* Converted percentage values into decimal format
* Example:

  * 25% → 0.25
  * 50% → 0.50

#### Rating Count Cleaning

* Removed formatting characters (commas)
* Converted values into integers
* Imputed missing values using the average rating count

#### Category Standardization

Standardized inconsistent category names into business-friendly groups:

| Original Category | Standardized Category   |
| ----------------- | ----------------------- |
| Home&Kitchen      | Kitchen Accessories     |
| Electronics       | Electronics Accessories |
| Computer          | Computer Accessories    |
| Musical           | Instrument Accessories  |
| Car               | Vehicle Accessories     |

#### Revenue Feature Engineering

Created an estimated revenue metric:

Revenue = Discounted Price × Rating Count

This metric was used as a proxy indicator for product demand and revenue potential.

#### Data Quality Validation

* Removed unnecessary fields
* Verified data types
* Checked for null values
* Checked for duplicate records
* Confirmed dataset readiness for visualization

---

## SQL Analysis

### 1. Revenue Performance Analysis

Identified product categories with the highest estimated revenue potential.

**Business Value**

* Highlights high-performing categories
* Supports inventory and investment decisions
* Helps prioritize profitable products

---

### 2. Product Quality Assessment

Analyzed category-level ratings to identify products that may require quality improvements.

**Business Value**

* Supports quality assurance initiatives
* Improves customer satisfaction
* Reduces potential product complaints

---

### 3. Marketing Opportunity Identification

Identified highly rated products with relatively lower customer engagement.

**Business Value**

* Supports promotional campaigns
* Increases product visibility
* Maximizes marketing ROI

---

### 4. Customer Engagement Analysis

Examined rating counts and category performance to identify areas with lower customer engagement.

**Business Value**

* Highlights categories requiring attention
* Supports customer experience optimization
* Provides insights into product adoption trends

---

### 5. Recommendation System Readiness

Prepared structured product review data suitable for future recommendation engine development.

Potential recommendation inputs:

* Product ratings
* Review volume
* Product category
* Discount level
* Revenue indicators

---

## Tableau Dashboard

The Tableau dashboard provides interactive visualizations for:

* Category performance analysis
* Revenue trends
* Product ratings comparison
* Customer engagement metrics
* Marketing opportunity identification
* Business insights and recommendations

### Dashboard Features

* Interactive filtering
* Category drill-down analysis
* Revenue performance tracking
* Customer rating distribution
* Product comparison views

---

## Key Insights

### Revenue Opportunities

* Identified categories with the highest estimated revenue contribution.
* Revealed products with strong customer demand and engagement.

### Quality Improvement Areas

* Highlighted categories with lower customer ratings.
* Provided opportunities for product enhancement initiatives.

### Marketing Opportunities

* Identified highly rated products that could benefit from additional promotion.

### Customer Experience Insights

* Uncovered engagement trends useful for customer retention and satisfaction strategies.

---

## Skills Demonstrated

### Data Analytics

* Data Cleaning
* Data Transformation
* Exploratory Data Analysis (EDA)
* KPI Development
* Business Intelligence

### SQL

* Data Validation
* Data Standardization
* Feature Engineering
* Aggregation & Analysis
* Data Preparation

### Tableau

* Dashboard Development
* Interactive Reporting
* Data Visualization
* Business Storytelling

### Business Analysis

* Requirements Translation
* Stakeholder-Focused Insights
* Revenue Analysis
* Customer Experience Optimization
* Strategic Recommendations

---

## Future Enhancements

* Implement sentiment analysis using review text.
* Build a machine learning recommendation engine.
* Develop customer segmentation models.
* Create predictive sales forecasting models.
* Integrate real-time product review monitoring.

---

## Author

**Matthew Ferrer**

Data Analytics | Business Intelligence | Tableau | SQL | Business Analysis

This project demonstrates the application of data analytics and business analysis techniques to transform customer review data into actionable business insights that support revenue growth, customer satisfaction, and strategic decision-making.
