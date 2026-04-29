--Bonus Query
-- BUSINESS QUESTION: What % of total revenue does each product contribute? Which products cumulatively make up the first 50% of revenue?
--Techniques: CTE-SUM() OVER-ROUND()-% calc-Product
-- Finding: Q8 Product revenue share & running total
--Advanced

WITH products_revenue AS (
    SELECT p.product_name,
        ROUND(SUM(od.unit_price * od.quantity - od.discount):: NUMERIC,2) AS total_revenue
    FROM products p
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY p.product_name
    ORDER BY total_revenue DESC
),

compounding_revenue AS(
SELECT *,
    SUM(total_revenue) OVER(ORDER BY total_revenue DESC) AS running_revenue,
    SUM(total_revenue) OVER() AS SUM_revenue
    FROM products_revenue
)

SELECT *,
    ROUND(((running_revenue / SUM_revenue) * 100) :: NUMERIC,2)AS cumulative_revenue_pct,
    DENSE_RANK() OVER( ORDER BY running_revenue ) AS rnk
FROM compounding_revenue