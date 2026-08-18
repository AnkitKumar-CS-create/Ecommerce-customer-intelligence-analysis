# E-Commerce Customer Intelligence Analysis

## Project Overview

An end-to-end customer analytics project focused on **revenue concentration, customer value, repeat-purchase behavior, promotion audiences, and product opportunities**.

**Workflow:** CSV → Python/Pandas → Feature Engineering → SQL → Power BI

## Dataset
3,900 customer shopping records with demographic, product, transaction, subscription, shipping, discount, rating, payment, and previous-purchase fields.

## What makes this analysis distinct
- Created transparent **behavioral segments** from `previous_purchases`.
- Added a **quartile-based transaction value tier**: Entry, Core, Premium, High Value.
- Created a combined **promotion audience** flag using discount and subscription status.
- Added revenue-share analysis by category and product.
- Added location-level revenue concentration analysis.
- Added a product quality/scale view using rating, revenue share, and minimum transaction thresholds.
- Added SQL window-function ranking for the top three products inside each category.
- Added SQL quartile-based value-tier analysis.

## Data preparation
- 37 missing review ratings are imputed with the median rating of the corresponding product category.
- Column names are standardized to snake_case.
- Purchase-frequency labels are mapped to approximate day intervals.
- `promo_code_used` is removed from the cleaned analysis dataframe because it duplicates the discount signal in this dataset.

## Power BI
Power BI is the presentation layer. The repository includes the baseline `.pbix` report plus `POWERBI_BUILD_SPEC.md`, which defines the independent dashboard story and exact redesign. The redesign should be completed on Windows Power BI Desktop before claiming the report itself was modified.

## Key analytical questions
1. Where is revenue concentrated across categories and locations?
2. Which customer-history segments contribute the most revenue?
3. How does current transaction value vary across value tiers?
4. Where are discounts concentrated, and what is the AOV of each promotion audience?
5. Which products combine meaningful sales scale with strong ratings?
6. How do season, shipping and payment dimensions relate to spending?

## Important limitation
The dataset is cross-sectional and does not provide a full longitudinal transaction history. Therefore, the project uses `previous_purchases` for behavioral segmentation but does **not** claim true churn, cohort retention, or causal subscription/discount effects.

## Tech Stack
Python, Pandas, Jupyter Notebook, SQL/PostgreSQL, Power BI, Git/GitHub.

## Run locally
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```
Open `Customer_Trends_Analysis.ipynb` and run the cells. Execute `customer_trends_sql_queries.sql` against a cleaned `customer` table.

## Project Files
- `Customer_Trends_Analysis.ipynb` — cleaning, feature engineering and analysis
- `customer_shopping_behavior.csv` — source data
- `customer_trends_sql_queries.sql` — business SQL
- `customer_trends_dashboard.pbix` — Power BI baseline report
- `POWERBI_BUILD_SPEC.md` — exact dashboard redesign specification
- `PROJECT_CHANGE_LOG.md` — change history
- `INTERVIEW_GUIDE.md` — interview preparation
