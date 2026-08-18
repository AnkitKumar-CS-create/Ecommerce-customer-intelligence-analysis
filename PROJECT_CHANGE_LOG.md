# Project Change Log

## Baseline
The project started from a customer shopping analytics repository containing a CSV dataset, Python notebook, SQL queries and a Power BI report.

## Independent analysis changes

### Python
- Reframed the notebook around revenue concentration, customer value, promotion audiences and product opportunities.
- Added fixed age bands.
- Added purchase-frequency-to-days conversion.
- Added rule-based customer-history segmentation.
- Added quartile-based transaction value tiers.
- Added a combined promotion audience feature.
- Added category/location revenue concentration.
- Added product rating + commercial scale analysis.
- Added payment, shipping, season and age summaries.

### SQL
- Replaced the business question set with category/location concentration, top products within category, value tiers, promotion audiences, rating-scale analysis, and season/shipping analysis.
- Added `DENSE_RANK()` partitioned by category.
- Added PostgreSQL percentile-based quartile logic.
- Added minimum-volume filters for product discount/rating analysis to avoid overinterpreting tiny samples.

### Power BI
- Power BI remains the presentation layer. The existing PBIX is retained as the baseline artifact.
- Added `POWERBI_BUILD_SPEC.md` defining the independent three-page dashboard story, KPI set, slicers and DAX measures.
- The actual PBIX redesign must be performed in Power BI Desktop on Windows; it is not being falsely represented as completed on macOS.

### Documentation
- Rewrote README around the new analytical questions.
- Added interview-oriented explanations and limitations.

## Integrity note
The same source dataset can be reused, but the analytical questions, feature engineering, SQL logic and dashboard story should be understood and presented by the project owner. Do not claim that the baseline PBIX was redesigned unless it is actually edited.
