-- E-Commerce Customer Intelligence Analysis
-- PostgreSQL / compatible SQL
-- Revised business questions for the independent project

-- 1. Executive KPIs
SELECT COUNT(*) AS transactions, COUNT(DISTINCT customer_id) AS customers,
       ROUND(SUM(purchase_amount), 2) AS total_revenue,
       ROUND(AVG(purchase_amount), 2) AS average_order_value
FROM customer;

-- 2. Revenue concentration by category
SELECT category, COUNT(*) AS orders, ROUND(SUM(purchase_amount),2) AS revenue,
       ROUND(100.0 * SUM(purchase_amount) / SUM(SUM(purchase_amount)) OVER (), 2) AS revenue_share_pct
FROM customer GROUP BY category ORDER BY revenue DESC;

-- 3. Geographic revenue concentration
SELECT location, COUNT(*) AS orders, ROUND(SUM(purchase_amount),2) AS revenue,
       ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer GROUP BY location ORDER BY revenue DESC LIMIT 10;

-- 4. Top products within each category
WITH product_totals AS (
  SELECT category, item_purchased, COUNT(*) AS orders, SUM(purchase_amount) AS revenue
  FROM customer GROUP BY category, item_purchased
), ranked AS (
  SELECT *, DENSE_RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS product_rank
  FROM product_totals
)
SELECT category, item_purchased, orders, ROUND(revenue,2) AS revenue, product_rank
FROM ranked WHERE product_rank <= 3 ORDER BY category, revenue DESC;

-- 5. Behavioral segment performance
WITH segments AS (
  SELECT customer_id, purchase_amount, previous_purchases,
    CASE WHEN previous_purchases <= 5 THEN 'New / Low-Repeat'
         WHEN previous_purchases <= 20 THEN 'Returning'
         ELSE 'Loyal' END AS customer_segment
  FROM customer
)
SELECT customer_segment, COUNT(*) AS customers, ROUND(SUM(purchase_amount),2) AS revenue,
       ROUND(AVG(purchase_amount),2) AS avg_order_value, ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM segments GROUP BY customer_segment ORDER BY revenue DESC;

-- 6. Current transaction value tiers using quartile boundaries
WITH quartiles AS (
  SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY purchase_amount) AS q1,
         percentile_cont(0.50) WITHIN GROUP (ORDER BY purchase_amount) AS q2,
         percentile_cont(0.75) WITHIN GROUP (ORDER BY purchase_amount) AS q3
  FROM customer
), tiered AS (
  SELECT c.*, CASE WHEN purchase_amount <= q1 THEN 'Entry'
                  WHEN purchase_amount <= q2 THEN 'Core'
                  WHEN purchase_amount <= q3 THEN 'Premium'
                  ELSE 'High Value' END AS value_tier
  FROM customer c CROSS JOIN quartiles
)
SELECT value_tier, COUNT(*) AS customers, ROUND(SUM(purchase_amount),2) AS revenue,
       ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM tiered GROUP BY value_tier ORDER BY revenue DESC;

-- 7. Subscription association with spend and purchase history
SELECT subscription_status, COUNT(*) AS customers, ROUND(SUM(purchase_amount),2) AS revenue,
       ROUND(AVG(purchase_amount),2) AS avg_order_value, ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM customer GROUP BY subscription_status ORDER BY revenue DESC;

-- 8. Promotion audience analysis
SELECT CASE WHEN discount_applied='Yes' AND subscription_status='Yes' THEN 'Discounted Subscriber'
            WHEN discount_applied='Yes' AND subscription_status='No' THEN 'Discounted Non-Subscriber'
            ELSE 'No Discount' END AS promotion_audience,
       COUNT(*) AS orders, ROUND(SUM(purchase_amount),2) AS revenue,
       ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer GROUP BY 1 ORDER BY revenue DESC;

-- 9. Products with highest discount adoption (minimum 30 orders)
SELECT item_purchased, COUNT(*) AS orders,
       SUM(CASE WHEN discount_applied='Yes' THEN 1 ELSE 0 END) AS discounted_orders,
       ROUND(100.0 * SUM(CASE WHEN discount_applied='Yes' THEN 1 ELSE 0 END) / COUNT(*),2) AS discount_rate_pct
FROM customer GROUP BY item_purchased HAVING COUNT(*) >= 30 ORDER BY discount_rate_pct DESC LIMIT 10;

-- 10. Rating vs commercial scale
SELECT item_purchased, COUNT(*) AS orders, ROUND(AVG(review_rating),2) AS avg_rating,
       ROUND(SUM(purchase_amount),2) AS revenue
FROM customer GROUP BY item_purchased HAVING COUNT(*) >= 50 ORDER BY avg_rating DESC, revenue DESC;

-- 11. Season and shipping comparison
SELECT season, COUNT(*) AS orders, ROUND(SUM(purchase_amount),2) AS revenue, ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer GROUP BY season ORDER BY revenue DESC;

SELECT shipping_type, COUNT(*) AS orders, ROUND(SUM(purchase_amount),2) AS revenue, ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer GROUP BY shipping_type ORDER BY avg_order_value DESC;

-- 12. High-value discounted transactions
SELECT customer_id, item_purchased, category, purchase_amount, previous_purchases, subscription_status
FROM customer
WHERE discount_applied='Yes'
  AND purchase_amount > (SELECT AVG(purchase_amount) FROM customer)
ORDER BY purchase_amount DESC;
