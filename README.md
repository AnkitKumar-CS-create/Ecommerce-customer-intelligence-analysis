# E-Commerce Customer Intelligence Analysis

## Project Overview

This project analyzes customer shopping transactions to identify **revenue drivers, product opportunities, customer segments, discount behavior, and purchasing patterns**.

The analysis follows an end-to-end analytics workflow:

**CSV → Python/Pandas → Data Cleaning & Feature Engineering → SQL Business Analysis → Power BI Dashboard → Business Recommendations**

The goal is not only to calculate metrics, but to turn transaction data into practical decisions around customer retention, promotions, product focus, and customer experience.

## Dataset

The dataset contains **3,900 transaction/customer records and 18 original columns** covering:

- customer demographics
- products and categories
- purchase amount
- location and season
- review rating
- subscription status
- shipping type
- discount usage
- previous purchases
- payment method
- purchase frequency

## What I changed / added

This version uses the original dataset as the starting point but restructures the analysis around a new business-focused question set.

### Python
- Added an executive KPI section.
- Added fixed business-friendly age groups.
- Added customer segmentation based on previous purchase history.
- Converted purchase-frequency labels into approximate days.
- Added category, product, subscription, discount, season, shipping and age analyses.
- Added discount-adoption analysis at product level.
- Added revenue-share calculations for customer segments and subscriptions.
- Improved data-quality checks and documentation.

### SQL
The SQL layer was rewritten around a new set of business questions and includes:
- KPI aggregation
- category performance
- top products
- customer segmentation with `CASE`
- subscription analysis
- discount effectiveness
- product discount adoption
- top-3 products per category using a window function
- age-group analysis
- seasonal analysis
- shipping analysis
- high-value discounted transactions

### Power BI
The dashboard should be presented as an **E-Commerce Customer Intelligence Dashboard** rather than copying the original dashboard layout.

Recommended pages:
1. **Executive Overview** — Revenue, transactions, AOV, customer segments
2. **Customer Intelligence** — New/Returning/Loyal, subscription, age groups
3. **Product & Promotion** — category/product revenue, ratings, discount adoption

## Key findings from the dataset

These are calculated from the supplied dataset and should be used instead of copying the original repository's stated insights.

- Total transaction value is **$233,081** across 3,900 records.
- Average order value is approximately **$59.76**.
- Clothing is the largest category by revenue at approximately **$104.3K**.
- Male transactions contribute substantially more total revenue than female transactions in this sample, primarily because the dataset contains more male records.
- Fall has the highest seasonal revenue at approximately **$60.0K** and the highest average order value at about **$61.56**.
- Customers with no discount have a slightly higher average order value than discounted transactions.
- 2-Day Shipping has the highest average order value among the shipping types at about **$60.73**.
- Blouse, Shirt and Dress are among the highest-revenue individual products.
- The dataset contains 37 missing review ratings, which are imputed using category-level medians.

## Important analytical limitation

The dataset contains one transaction row per customer ID in this supplied version, while `previous_purchases` represents historical purchase count. Therefore, the project can analyze **repeat-purchase history**, but it should not claim to calculate true customer retention, churn, or cohort retention without longitudinal transaction data.

## Tech Stack

- Python
- Pandas
- Jupyter Notebook
- PostgreSQL / SQL
- Power BI
- Git / GitHub

## Project Structure

```text
Customer-Trends-Analysis/
├── Customer_Trends_Analysis.ipynb
├── customer_shopping_behavior.csv
├── customer_trends_sql_queries.sql
├── customer_trends_dashboard.pbix
├── requirements.txt
├── README.md
├── PROJECT_CHANGE_LOG.md
└── INTERVIEW_GUIDE.md
```

## How to run

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Open `Customer_Trends_Analysis.ipynb` and run the cells from top to bottom.

For SQL analysis, load the cleaned `customer` table into PostgreSQL and execute `customer_trends_sql_queries.sql`.

Open the PBIX file in Power BI Desktop and rebuild/refresh the dashboard using the revised KPI and chart plan documented in `INTERVIEW_GUIDE.md`.

## Business recommendations

1. Focus merchandising attention on high-revenue categories and products.
2. Use customer-history segments to design different retention campaigns.
3. Avoid assuming discounts automatically increase order value; compare discounted and non-discounted AOV before running promotions.
4. Promote highly rated, high-revenue products where customer satisfaction and commercial performance overlap.
5. Use shipping behavior to understand whether customers who choose faster delivery also show higher spending.

## Author

**Ankit Kumar**
