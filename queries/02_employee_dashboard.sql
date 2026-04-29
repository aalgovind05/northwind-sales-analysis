--BUSINESS QUESTIONFor each employee: total orders handled, total revenue generated, average order value, rank by revenue.
-- Techniques: CTE + JOIN + RANK() window function
-- Finding: Q2 Employee Performance Dashboard

WITH employee_stats AS (
    SELECT
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name)        AS employee_name,
        e.title,
        COUNT(DISTINCT o.order_id)                     AS total_orders,
        ROUND(SUM(od.unit_price * od.quantity)::NUMERIC, 2) AS total_revenue,
        ROUND(AVG(od.unit_price * od.quantity)::NUMERIC, 2) AS avg_order_value
    FROM employees e
    JOIN orders o ON e.employee_id = o.employee_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY e.employee_id, e.first_name, e.last_name, e.title
)

SELECT *,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM employee_stats
ORDER BY revenue_rank