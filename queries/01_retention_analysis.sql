--BUSINESS QUESTION*1. Customer Retention Analysis*
--Which customers ordered more than once? What's the gap between their first and last order?
-- Techniques: CTE + MIN() / MAX() + HAVING


 WITH order_info AS (
    SELECT c.contact_name,
        c.customer_id,
        c.country,
        COUNT(o.order_id) total_order,
        MIN(o.order_date) AS first_order_date,
        MAX(o.order_date) AS last_order_date,
        MAX(o.order_date) - MIN(o.order_date) AS date_gap
    FROM customers c 
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.contact_name,
        c.customer_id,
        c.country
    HAVING COUNT(o.order_id) > 1
 )

SELECT *
FROM order_info
ORDER BY date_gap DESC


--BUSINESS QUESTION 2. Employee Performance Dashboard*
--For each employee: total orders handled, total revenue generated, average order value, rank by revenue.
--Techniques: CTE + JOIN + RANK() window function