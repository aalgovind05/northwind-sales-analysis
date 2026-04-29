-- BUSINESS QUESTION: Products with stock below 15 units that still have active orders in the last 6 months.
-- Techniques: JOIN + WHERE + date filtering + CASE WHEN for urgency label
-- Finding: Q3 Product Restock Alert


SELECT
    p.product_name,
    CASE
            WHEN p.units_in_stock = 0 THEN 'critical'
            WHEN p.units_in_stock <= p.reorder_level  THEN 'warning' 
            ELSE 'low' 
            END AS stock_status,
    p.units_in_stock,
    p.reorder_level,
    COUNT(DISTINCT o.order_id) as recent_orders
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
JOIN orders o
    ON od.order_id = o.order_id
WHERE p.units_in_stock < 15 AND o.order_date >=(SELECT MAX(order_date) AS last_date FROM orders) - INTERVAL '6 months'
GROUP BY p.product_id,p.units_in_stock
ORDER BY p.units_in_stock

/*

--how many Products stock is critical and how many are in warning zone


WITH temp AS (
SELECT
    p.product_name,
    CASE
            WHEN p.units_in_stock = 0 THEN 'critical'
            WHEN p.units_in_stock <= p.reorder_level  THEN 'warning' 
            ELSE 'low' 
            END AS stock_status,
    p.units_in_stock,
    p.reorder_level,
    COUNT(DISTINCT o.order_id) as recent_orders
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
JOIN orders o
    ON od.order_id = o.order_id
WHERE p.units_in_stock < 15 AND o.order_date >=(SELECT MAX(order_date) AS last_date FROM orders) - INTERVAL '6 months'
GROUP BY p.product_id,p.units_in_stock
ORDER BY p.units_in_stock
)

SELECT stock_status,COUNT(stock_status) AS stock_update
FROM temp
GROUP BY stock_status  */