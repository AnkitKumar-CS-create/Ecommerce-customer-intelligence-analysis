# Interview Guide — E-Commerce Customer Intelligence Analysis

## 1. 60-second project explanation

> I worked on an end-to-end e-commerce customer analytics project where the goal was to understand customer purchasing behavior and identify the main revenue and business drivers. I started with around 3,900 transaction records in CSV format and used Python with Pandas for data cleaning and feature engineering. I handled missing review ratings using category-level median imputation, standardized the column names, created age groups, converted purchase frequency into approximate days, and segmented customers using their previous purchase history. I then used SQL to answer business questions around category revenue, top products, subscription behavior, discount effectiveness, shipping, seasonality and customer segments. Finally, I used Power BI to turn the analysis into an interactive dashboard with executive KPIs and customer/product views. The main objective was to move from raw transaction data to actionable recommendations for retention, promotions and product strategy.

## 2. Project workflow

```text
Raw CSV
   ↓
Python / Pandas
   ↓
Data Cleaning
   ↓
Feature Engineering
   ↓
Exploratory Analysis
   ↓
PostgreSQL / SQL
   ↓
Business Questions
   ↓
Power BI
   ↓
Insights & Recommendations
```

## 3. Dataset explanation

The supplied dataset has:
- 3,900 records
- 18 original columns

Important columns:
- `customer_id` — identifier
- `age`, `gender` — demographics
- `item_purchased`, `category` — product information
- `purchase_amount` — transaction value
- `location`, `season` — context
- `review_rating` — customer rating
- `subscription_status` — subscription indicator
- `shipping_type` — delivery method
- `discount_applied` — discount flag
- `previous_purchases` — historical purchase count
- `payment_method`
- `frequency_of_purchases`

## 4. Why Python?

Python/Pandas was used for:
- loading the CSV
- understanding the schema
- checking missing values
- cleaning columns
- feature engineering
- exploratory summaries

Python is useful because it is flexible for data preparation and can automate repetitive analysis.

## 5. Why did you use median imputation?

There were missing values in `review_rating`.

Instead of filling every missing value with one global median, I used the median rating of the corresponding product category.

Why?

Because different categories can have different rating distributions. Category-level imputation preserves more of the local structure of the data and is less likely to distort a category's typical rating.

## 6. Why standardize column names?

Original names contained spaces, capitalization and special characters.

For example:

`Purchase Amount (USD)`

became:

`purchase_amount`

This makes Python and SQL queries easier to write, reduces syntax problems and gives the dataset a consistent naming convention.

## 7. Explain age groups

I created four business-friendly age groups:

- Young Adult
- Adult
- Middle-aged
- Senior

The purpose is to make demographic analysis easier to interpret than working with individual ages.

## 8. Explain purchase frequency

The source contains text such as:
- Weekly
- Fortnightly
- Monthly
- Quarterly
- Annually

I mapped these to approximate days:

- Weekly → 7
- Fortnightly → 14
- Monthly → 30
- Quarterly → 90
- Annually → 365

This converts a categorical frequency into a numerical feature that can be compared or used in future modeling.

## 9. Explain customer segmentation

I used `previous_purchases` as a simple behavioral segmentation signal:

- 1–5 → New / Low-Repeat
- 6–20 → Returning
- >20 → Loyal

The purpose is not to claim a formal CRM segmentation model. It is a transparent rule-based segmentation that can be easily explained to business stakeholders.

## 10. Why SQL after Python?

Python is strong for cleaning and preparation.

SQL is useful for answering repeatable business questions directly from a structured database.

Using both demonstrates an end-to-end analytics workflow rather than relying on only one tool.

## 11. SQL concepts you used

Be ready to explain:

### GROUP BY
Groups rows by a business dimension.

Example:
`GROUP BY category`

lets us calculate revenue separately for each product category.

### SUM
Used for total revenue.

### AVG
Used for average order value and ratings.

### COUNT
Used for transaction/customer counts.

### CASE
Used for rule-based customer segmentation.

### CTE
A Common Table Expression temporarily names an intermediate result, making a complex query easier to read.

### Subquery
Used when a calculation depends on another query result, such as comparing a transaction against the overall average purchase amount.

### Window function
I used `DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC)` to rank products inside each category.

This is useful because a normal `ORDER BY` can give a global ranking, while the window function lets me rank separately within every category.

## 12. Explain the top-3-products query

The query first aggregates each product's performance within its category.

Then:

```sql
DENSE_RANK() OVER (
    PARTITION BY category
    ORDER BY SUM(purchase_amount) DESC
)
```

assigns a rank starting again from 1 for each category.

Finally, I filter for ranks <= 3.

This gives the top three products within every category.

## 13. Explain discount analysis

I compared:
- number of discounted orders
- revenue
- average order value

between discounted and non-discounted transactions.

The important business point is that a discount should not automatically be considered successful simply because it generates orders. We should also examine order value and revenue contribution.

## 14. Explain subscription analysis

I compared subscribers and non-subscribers using:
- number of records
- total revenue
- average order value
- previous purchase history

This helps identify whether subscription status is associated with stronger purchasing behavior.

Important: this is an association analysis, not proof that subscriptions cause higher spending.

## 15. Why Power BI?

Power BI was used for the presentation layer because it allows:
- interactive filtering
- KPI cards
- charts
- category comparisons
- customer segmentation views
- business-friendly dashboards

Python and SQL produce the analysis; Power BI makes the findings easier for stakeholders to consume.

## 16. Recommended Power BI dashboard

### Page 1 — Executive Overview
KPI cards:
- Total Revenue
- Transactions
- Average Order Value
- Discounted Orders

Charts:
- Revenue by Category
- Revenue by Season
- Revenue by Gender
- Revenue by Shipping Type

Slicers:
- Category
- Season
- Gender
- Subscription Status

### Page 2 — Customer Intelligence
KPIs:
- New / Low-Repeat
- Returning
- Loyal

Charts:
- Revenue by Customer Segment
- Revenue by Age Group
- Subscription vs Non-Subscription
- Previous Purchases distribution

### Page 3 — Product & Promotion
Charts:
- Top 10 Products by Revenue
- Product Rating vs Revenue
- Discount Rate by Product
- Discounted vs Non-Discounted AOV

## 17. Key numbers you should remember

From the supplied dataset:

- Records: **3,900**
- Total revenue: **$233,081**
- Average order value: **~$59.76**
- Clothing revenue: **~$104.3K**
- Accessories revenue: **~$74.2K**
- Footwear revenue: **~$36.1K**
- Outerwear revenue: **~$18.5K**
- Fall revenue: **~$60.0K**
- Missing review ratings before cleaning: **37**

Do not memorize every number. Remember the main patterns and be able to explain how you calculated them.

## 18. Important limitation

Do NOT say:

> "I calculated customer retention/churn."

The dataset does not contain a longitudinal transaction history suitable for true retention or churn analysis.

Say instead:

> "I used previous purchase history as a proxy for customer behavioral segmentation."

That answer is much more defensible.

## 19. Likely interview questions

### Q: What was the hardest part?
**Answer:**
> The main challenge was turning raw transaction fields into business-ready features and deciding which metrics were actually useful. I focused on transparent features such as purchase-history segments, age groups and purchase-frequency days.

### Q: Why did you choose this project?
> It covers the complete analytics workflow from data cleaning to SQL analysis and dashboarding, so it allowed me to demonstrate multiple practical analytics skills in one project.

### Q: What business decision can your analysis support?
> It can help prioritize products and categories, identify customer segments for retention campaigns, evaluate discount usage, and understand purchasing behavior across shipping, season and subscription dimensions.

### Q: What would you improve?
> I would add longitudinal transaction data and build cohort retention analysis. I would also add predictive modeling for repeat purchase or customer lifetime value once sufficient historical data is available.

### Q: What would you do with more data?
> I would build customer-level RFM features, cohort analysis, lifetime value estimation and potentially a churn or repeat-purchase prediction model.

### Q: What is AOV?
> Average Order Value. It is total purchase revenue divided by the number of transactions.

### Q: What is the difference between revenue and average order value?
> Revenue measures the total monetary value generated. AOV measures the average value of one transaction.

### Q: Why use a dashboard?
> A dashboard makes trends and comparisons easier to consume and allows non-technical stakeholders to filter and explore the data.

## 20. If asked "Did you use AI?"

Be honest about your actual usage. A safe explanation is:

> "I used AI as a development assistant for brainstorming and debugging, but I reviewed and understood the data preparation, SQL logic, metrics and dashboard decisions myself."

Do not claim that you personally wrote every line if that is not true.

## 21. One-line project summary

> **An end-to-end e-commerce analytics project using Python, SQL and Power BI to identify revenue drivers, customer segments, product opportunities and promotion patterns.**
