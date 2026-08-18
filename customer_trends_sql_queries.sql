-- E-Commerce Customer Intelligence Analysis
-- PostgreSQL
-- Business questions selected for the revised project

-- 1. Executive revenue KPIs
SELECT
    COUNT(*) AS transactions,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(purchase_amount), 2) AS total_revenue,
    ROUND(AVG(purchase_amount), 2) AS average_order_value
FROM customer;

-- 2. Revenue and order value by product category
SELECT
    category,
    COUNT(*) AS orders,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value
FROM customer
GROUP BY category
ORDER BY revenue DESC;

-- 3. Top products by revenue
SELECT
    item_purchased,
    COUNT(*) AS orders,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(review_rating::numeric), 2) AS avg_rating
FROM customer
GROUP BY item_purchased
ORDER BY revenue DESC
LIMIT 10;

-- 4. Customer segmentation using purchase history
WITH segmented AS (
    SELECT
        customer_id,
        purchase_amount,
        CASE
            WHEN previous_purchases <= 5 THEN 'New / Low-Repeat'
            WHEN previous_purchases <= 20 THEN 'Returning'
            ELSE 'Loyal'
        END AS customer_segment
    FROM customer
)
SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value
FROM segmented
GROUP BY customer_segment
ORDER BY revenue DESC;

-- 5. Subscription performance
SELECT
    subscription_status,
    COUNT(*) AS customers,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer
GROUP BY subscription_status
ORDER BY revenue DESC;

-- 6. Discount effectiveness
SELECT
    discount_applied,
    COUNT(*) AS orders,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value
FROM customer
GROUP BY discount_applied
ORDER BY avg_order_value DESC;

-- 7. Products with the highest discount adoption
SELECT
    item_purchased,
    COUNT(*) AS orders,
    SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) AS discounted_orders,
    ROUND(
        100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS discount_rate_pct
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate_pct DESC
LIMIT 10;

-- 8. Top 3 products within every category using a window function
WITH product_rank AS (
    SELECT
        category,
        item_purchased,
        COUNT(*) AS orders,
        SUM(purchase_amount) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(purchase_amount) DESC
        ) AS product_rank
    FROM customer
    GROUP BY category, item_purchased
)
SELECT
    category,
    item_purchased,
    orders,
    ROUND(revenue, 2) AS revenue
FROM product_rank
WHERE product_rank <= 3
ORDER BY category, revenue DESC;

-- 9. Revenue by age group
SELECT
    age_group,
    COUNT(*) AS orders,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value
FROM customer
GROUP BY age_group
ORDER BY revenue DESC;

-- 10. Seasonal performance
SELECT
    season,
    COUNT(*) AS orders,
    ROUND(SUM(purchase_amount), 2) AS revenue,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value
FROM customer
GROUP BY season
ORDER BY revenue DESC;

-- 11. Shipping behavior
SELECT
    shipping_type,
    COUNT(*) AS orders,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value,
    ROUND(SUM(purchase_amount), 2) AS revenue
FROM customer
GROUP BY shipping_type
ORDER BY avg_order_value DESC;

-- 12. High-value discounted transactions
SELECT
    customer_id,
    item_purchased,
    category,
    purchase_amount,
    previous_purchases,
    subscription_status
FROM customer
WHERE discount_applied = 'Yes'
  AND purchase_amount > (SELECT AVG(purchase_amount) FROM customer)
ORDER BY purchase_amount DESC;
