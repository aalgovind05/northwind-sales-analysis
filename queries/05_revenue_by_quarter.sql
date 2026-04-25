-- BUSINESS QUESTION 5. Revenue by Quarter*
-- Hint:
--EXTRACT(YEAR FROM order_date) AS year,
--EXTRACT(QUARTER FROM order_date) AS quarter
--Include: quarter-over-quarter % change using LAG().
--Techniques: EXTRACT + CTE + LAG() window function

WITH quarter_revenue AS(
SELECT
    ROUND((SUM(od.unit_price * od.quantity - od.discount)) :: NUMERIC, 2)AS total_revenue,
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(QUARTER FROM o.order_date) AS quarter
FROM order_details od
JOIN orders o
    ON od.order_id = o.order_id
GROUP BY year,quarter
),

pre_quarter AS (
    SELECT 
    year,
    quarter,
    total_revenue,
    LAG(total_revenue) OVER( ORDER BY year,quarter)  pre_quarter_revenue,
    (total_revenue - LAG(total_revenue) OVER( ORDER BY year,quarter))  revenue_change
FROM quarter_revenue
)

SELECT 
   CONCAT(year :: INT, ' Q', quarter :: INT) AS period,
    total_revenue,
    pre_quarter_revenue,
    revenue_change,
    ROUND((revenue_change / pre_quarter_revenue * 100):: NUMERIC, 2) AS quarter_change_per
FROM  pre_quarter
ORDER BY year, quarter;