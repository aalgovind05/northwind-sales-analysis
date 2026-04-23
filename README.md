# northwind-sales-analysis 
End to end SQL analytics project of NORTHWIND dataset covering 8 real world business questions across 14 tables 

## Business question and answered 
| # | Questions| Technique used|
| 1 | Which customers ordered more than once? What's the gap between their first and last order? | CTE + MIN() / MAX() + HAVING |
| 2 | For each employee: total orders handled, total revenue generated, average order value, rank by revenue. | CTE + JOIN + RANK() window function |



## Key findings
- ** Jose Pavarotti leads in order frequency with 31 orders over 570 days — one order every 18 days — against a dataset average of 9.42 orders and 496 days retention, mean Pavarotti orders at 3.4x the customer average thats making him the highest-value repeat customer.
- ** john steel have 2 order in 62 day - one order in 31 days - compare to dataset average of 9.42 orders and 496 days it's indicate his non interest or customer churn posibility 
  

 ## Tech Stack

- PostgreSQL 15
- pgAdmin 4


## How to Run

1. Restore the superstore database using `data/NORTHWIND-SALES-ANALYSIS.sql`
2. Run queries in `/queries` in numbered order
3. Each file has the business question and expected output in the header comments