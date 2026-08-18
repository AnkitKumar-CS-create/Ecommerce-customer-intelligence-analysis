# Interview Guide — E-Commerce Customer Intelligence Analysis

## 1. 60-second explanation

> I built an end-to-end e-commerce customer intelligence project to understand where revenue is concentrated, which customer-history segments matter, how promotions behave, and which products combine sales scale with customer ratings. I started with 3,900 shopping records and used Python with Pandas for data-quality checks, category-level median imputation, column standardization and feature engineering. I created behavioral customer segments from previous purchase history, quartile-based transaction value tiers, and promotion audiences combining discount and subscription status. I then used SQL for repeatable business analysis, including revenue-share calculations, CTEs, subqueries, percentile-based tiers and window functions to rank products within each category. Power BI is the presentation layer, where the analysis is organized into executive, customer and product/promotion views.

## 2. Dataset
- 3,900 records
- 18 original columns
- Demographics: age, gender, location
- Product: item, category, size, color
- Transaction: purchase amount, season, shipping, payment
- Customer behavior: previous purchases, frequency, subscription
- Promotion: discount and promo-code fields
- Rating: review rating

## 3. Cleaning
**Missing ratings:** 37 values were missing. I used the median rating within each category rather than one global median.

**Column names:** standardized to snake_case to make Python/SQL code consistent.

**Promo field:** `promo_code_used` is redundant with the discount signal for this dataset, so it is removed from the cleaned analytical dataframe.

## 4. Feature engineering
### Customer segment
- 0–5 previous purchases → New / Low-Repeat
- 6–20 → Returning
- >20 → Loyal

This is rule-based behavioral segmentation, not machine learning.

### Value tier
Current transaction amount is split into quartiles: Entry, Core, Premium and High Value. Quartiles are useful because they avoid arbitrary dollar thresholds and create similarly sized groups.

### Promotion audience
- Discounted Subscriber
- Discounted Non-Subscriber
- No Discount

This lets the business compare promotion behavior across subscription status.

## 5. Why Python?
Python/Pandas is useful for reproducible cleaning, transformation, feature engineering and exploratory analysis.

## 6. Why SQL?
SQL makes the business questions repeatable once the cleaned data is loaded into a relational table.

## 7. SQL concepts
- `GROUP BY` for category/segment summaries
- `SUM`, `AVG`, `COUNT` for KPIs
- `CASE` for customer segments and promotion audiences
- CTEs for readable multi-step analysis
- Subqueries for comparisons with overall averages
- `DENSE_RANK() OVER (PARTITION BY category ...)` for top products within each category
- `percentile_cont` for quartile-based value tiers in PostgreSQL

## 8. Power BI
Power BI is the presentation layer. The dashboard story should focus on: executive KPIs, revenue concentration, customer intelligence, and product/promotion performance.

## 9. Key business insights to discuss
Do not memorize random numbers. Explain patterns and how they were calculated. Examples:
- Which categories contribute the largest revenue share?
- Which locations contribute the most revenue?
- Which customer-history segment contributes the most revenue?
- Does discounted AOV exceed non-discounted AOV?
- Which products have both sufficient sales scale and strong ratings?
- Which promotion audience has the highest AOV?

## 10. Limitations
The dataset is cross-sectional. `previous_purchases` is historical count, not a timestamped transaction table. Therefore I would not claim true churn, cohort retention, or causal effects of discounts/subscriptions. With longitudinal data I would add RFM, cohort retention, customer lifetime value and predictive modeling.

## 11. Likely questions
**Why did you use quartiles for value tiers?**
> To avoid arbitrary fixed dollar thresholds and create balanced, interpretable transaction-value groups.

**Is your customer segmentation machine learning?**
> No. It is transparent rule-based segmentation using previous purchase history. A future version could use clustering if customer-level longitudinal data were available.

**Why category-level median imputation?**
> Ratings can differ by category, so category-level imputation preserves local distribution better than one global median.

**What does your window function do?**
> It restarts ranking inside each category, allowing me to return the top three products per category rather than the top three globally.

**What would you improve next?**
> Add longitudinal transactions, build RFM/cohort features, evaluate customer lifetime value and test repeat-purchase or churn prediction.
