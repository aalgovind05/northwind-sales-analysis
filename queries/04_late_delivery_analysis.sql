--BUSINESS QUESTION 4. Late Delivery Analysis*
--Orders where actual delivery (shipped_date) exceeded the required date (required_date). Calculate how many days late.


SELECT 
    c.contact_name,
    CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    (o.shipped_date - o.required_date) AS days_late,
    o.ship_country
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN employees e
    ON e.employee_id = o.employee_id
WHERE (o.shipped_date - o.required_date) > 0
ORDER BY days_late DESC
