-- BUSINESS QUESTION: Employee performance vs team average
-- Techniques: CTE, CROSS JOIN, AVG()
-- Finding: 6 Employee & Operational Performance

WITH employee_revenue AS(
    SELECT 
        CONCAT(e.first_name,' ',e.last_name) AS employee_name,
        ROUND(SUM(od.unit_price*od.quantity - od.discount):: NUMERIC,2) AS emp_total_revenue
    FROM order_details od
    JOIN orders o
    ON od.order_id = o.order_id
    JOIN employees e
    ON o.employee_id = e.employee_id
    GROUP BY CONCAT(e.first_name,' ',e.last_name)
    ),

avg_team_revenue AS
(SELECT
ROUND(AVG(emp_total_revenue):: NUMERIC,2) AS team_revenue
FROM employee_revenue)

SELECT employee_name,
        emp_total_revenue,
        team_revenue,
            CASE 
                WHEN emp_total_revenue >= team_revenue
                THEN 'above average'
                ELSE 'coaching needs' END AS performance_status
FROM employee_revenue
CROSS JOIN avg_team_revenue
ORDER BY emp_total_revenue DESC ;

