
--BUSINESS QUESTION 2. Employee Performance Dashboard*
--For each employee: total orders handled, total revenue generated, average order value, rank by revenue.
--Techniques: CTE + JOIN + RANK() window function

WITH emp_performance AS(
    SELECT 
        CONCAT(e.first_name,' ',e.last_name) AS employee_name,
        COUNT(DISTINCT o.order_id) AS order_handled,
        ROUND(SUM(od.unit_price * od.quantity*(1 - od.discounts)):: NUMERIC,2) AS total_revenue,
        ROUND(SUM(od.unit_price * od.quantity) / COUNT(DISTINCT o.order_id):: NUMERIC,2) AS avg_order_value
    FROM employees e
    JOIN orders o
        ON e.employee_id = o.employee_id
    JOIN order_details od
        ON od.order_id = o.order_id
    GROUP BY e.last_name,e.first_name
)

SELECT *,
    RANK() OVER (ORDER BY total_revenue DESC) AS rnk
FROM emp_performance
SELECT * FROM order_details