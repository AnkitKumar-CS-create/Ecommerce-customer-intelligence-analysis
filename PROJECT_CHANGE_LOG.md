# Project Change Log

## Baseline

The project started from a cloned customer shopping analytics repository containing a CSV dataset, Python notebook, SQL queries and Power BI report.

The objective of this revision is to turn the baseline into a distinct, business-focused analytics project with a new analysis structure, new SQL questions, new documentation and a new dashboard story.

## Changes made

### 1. Project positioning
- Renamed the project concept to **E-Commerce Customer Intelligence Analysis**.
- Reframed the business objective around revenue drivers, customer segments, product opportunities and promotion effectiveness.

### 2. Python notebook
- Reorganized the notebook into logical sections:
  - data loading
  - data quality
  - cleaning
  - feature engineering
  - executive KPIs
  - product/category analysis
  - customer segmentation
  - subscription analysis
  - discount analysis
  - season/shipping/age analysis
- Added executive KPI calculations.
- Added fixed age groups instead of the original quartile-based age grouping.
- Added `customer_segment` based on `previous_purchases`:
  - 1–5: New / Low-Repeat
  - 6–20: Returning
  - >20: Loyal
- Added revenue-share calculations.
- Added discount adoption by product.
- Added category/product summary tables.
- Added clearer comments explaining analytical decisions.
- Retained category-level median imputation for missing review ratings.
- Retained frequency-to-days conversion.
- Retained removal of the redundant promo-code field after validating that it duplicates discount status in this dataset.

### 3. SQL
The original query set was replaced with a new business-question-driven SQL script.

New query areas:
- executive KPIs
- category revenue
- top products
- customer segmentation
- subscription performance
- discount effectiveness
- discount adoption by product
- top 3 products per category
- age-group performance
- seasonal performance
- shipping performance
- high-value discounted transactions

The revised SQL deliberately demonstrates:
- `GROUP BY`
- aggregate functions
- `CASE`
- CTEs
- subqueries
- `DENSE_RANK() OVER (PARTITION BY ...)`
- conditional aggregation

### 4. README
- Rewritten completely.
- Added new project objective.
- Added methodology and limitations.
- Added calculated dataset findings.
- Added business recommendations.
- Removed unsupported/overstated claims from the baseline documentation.

### 5. Interview guide
Created `INTERVIEW_GUIDE.md` containing:
- 60-second project pitch
- end-to-end workflow
- explanation of every major Python step
- SQL concepts and likely questions
- Power BI explanation
- business insights
- limitations
- likely interviewer questions and concise answers

### 6. Dashboard direction
The existing PBIX file should be visually redesigned before final submission:
- change dashboard title
- change KPI arrangement
- change chart selection/order
- change slicers
- use the three-page structure described in the interview guide
- replace any copied insight text with the revised findings

## Git history action

Because the starting repository contains the previous owner's `.git` directory, the final personal repository should **not retain that Git history**.

Before pushing your final version:

```bash
rm -rf .git
git init
git add .
git commit -m "Build e-commerce customer intelligence analysis"
git branch -M main
git remote add origin <YOUR-GITHUB-REPOSITORY>
git push -u origin main
```

This creates a fresh repository history for your version.

## Final verification checklist

- [ ] Run notebook from top to bottom.
- [ ] Check that CSV path works.
- [ ] Execute SQL queries successfully.
- [ ] Redesign PBIX dashboard.
- [ ] Change PBIX report title.
- [ ] Update Git remote to your repository.
- [ ] Remove old `.git` history.
- [ ] Commit the revised project.
- [ ] Read `INTERVIEW_GUIDE.md` before interviews.
