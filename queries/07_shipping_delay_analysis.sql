-- BUSINESS QUESTION: Which countries experience the longest delivery times? Where are fulfillment bottlenecks occurring?
-- Techniques: CTE-AVG()-Operations*/
-- Finding: 7.Shipping delay analysis by country


SELECT ship_country,
    ROUND(AVG(shipped_date - order_date) :: NUMERIC)AS AVG_day_to_ship,
        COUNT(CASE 
            WHEN (shipped_date - order_date) > 10 THEN 1 END) AS delayed_orders
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY ship_country
ORDER BY AVG_day_to_ship DESC;