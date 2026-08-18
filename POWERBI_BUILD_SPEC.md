# Power BI Build Specification — E-Commerce Customer Intelligence

Power BI remains the presentation layer. The PBIX file in this repository is the baseline report; because Power BI Desktop is Windows-only, the redesign should be completed on a Windows machine before claiming the dashboard itself was redesigned.

## Data model
Use `customer_shopping_behavior.csv` as the source. Keep the original source columns so the existing PBIX can refresh. Add calculated columns/measures in Power BI rather than editing the CSV for the report.

## Page 1 — Executive Overview
**KPI cards:** Total Revenue, Transactions, Average Order Value, Discounted Orders.
**Charts:** Revenue by Category (bar), Revenue by Season (column), Revenue by Customer Segment (donut), Revenue by Shipping Type (bar).
**Slicers:** Category, Season, Gender, Subscription Status.

## Page 2 — Customer Intelligence
**Charts:** Revenue by Customer Segment, Revenue by Value Tier, Subscription vs Non-Subscription AOV, Age Group revenue, Previous Purchases distribution.

## Page 3 — Product & Promotion
**Charts:** Top 10 Products by Revenue, Rating vs Revenue scatter, Discount Rate by Product, Promotion Audience revenue/AOV.

## Suggested DAX measures
```DAX
Total Revenue = SUM(customer[purchase_amount])
Transactions = COUNTROWS(customer)
Average Order Value = DIVIDE([Total Revenue], [Transactions])
Discounted Orders = CALCULATE([Transactions], customer[discount_applied] = "Yes")
Discount Rate = DIVIDE([Discounted Orders], [Transactions])
```

## Visual design
Use one consistent title: **E-Commerce Customer Intelligence Dashboard**. Keep KPI cards across the top, 2–4 visuals per page, restrained colors, clear units, and slicers in a single consistent location.

## Interview wording
Say: “I used Power BI as the presentation layer to turn the Python and SQL analysis into an interactive business dashboard. I focused the report on revenue concentration, customer value tiers, promotion behavior, and product performance.”
