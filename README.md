# Northwind Sales Analysis

End to end SQL analytics project on the NORTHWIND dataset covering 8 real world business questions across 14 tables.

---

## Project Overview

This project is my SQL case study on the classic Northwind database.  
My goal is to think like a junior data analyst working for a trading company and use SQL to:

- Ask practical business questions.
- Write clear, production-style queries.
- Turn raw data into insights about customers, employees, products, regions and inventory.

Everything is done only with SQL using PostgreSQL and pgAdmin.

---

## Business Questions and SQL

| # | Question | Technique used | Query file |
|---|----------|----------------|------------|
| 1 | Customer Retention Analysis
Which customers ordered more than once? What's the gap between their first and last order?| CTE + MIN() / MAX() + HAVING | `queries/01_customer_retention.sql` |
| 2 | Employee Performance Dashboard 
For each employee: total orders handled, total revenue generated, average order value, rank by revenue.|  CTE + JOIN + RANK() window function| `queries/02_employee_performance.sql` |
| 3 | Product Restock Alert 
Products with stock below 15 units that still have active orders in the last 6 months. | JOIN + WHERE + date filtering + CASE WHEN for urgency label| `queries/03_product_restock.sql` |
| 4 | Late Delivery Analysis 
Orders where actual delivery (shipped_date) exceeded the required date (required_date). Calculate how many days late.| Multi-table JOIN + date arithmetic + WHERE| `queries/04_late_delivery.sql` |
| 5 | Revenue by Quarter | Calculate quarterly revenue and percentage change from the previous quarter. | EXTRACT + CTE + LAG() window function| `queries/05_revenue_by_quarter.sql` |
| 06 | Employee performance vs team average
Which employees are above average performers? Who needs coaching based on revenue generated? |
CTE+ CROSS JOIN+AVG()| `queries/06_employee_performance.sql` |
| 07 | Shipping delay analysis by country
Which countries experience the longest delivery times? Where are fulfillment bottlenecks occurring?|
CTE+ JOIN + date diff + GROUP BY| `queries/07_shipping_delay_analysis.sql` |
| 08 | Product revenue share & running total
What % of total revenue does each product contribute? Which products cumulatively make up the first 50% of revenue? |
CTE+SUM() OVER()+ROUND()+% calculation| `queries/08_product_revenue_share.sql` |



---

## Key Insights

### 1. High value repeat customers

- **Jose Pavarotti** leads in order frequency with 31 orders over 570 days — one order roughly every 18 days.  
- In the full dataset the average customer has 9.42 orders over 496 days of retention.  
- This means Jose Pavarotti orders at around **3.4x** the average customer frequency and is one of the highest value repeat customers in the data.

**Takeaway:** Customers like Jose Pavarotti should be treated as VIP customers with loyalty programs, special offers and proactive retention so that this revenue does not churn.

---

### 2. Possible churn risk

- **John Steel** has only 2 orders in 62 days — one order every 31 days.  
- Compared to the dataset average of 9.42 orders and 496 days retention, his activity is much lower.  
- This pattern looks like low engagement and a possible early churn signal.

**Takeaway:** Customers with very few orders and short retention windows should be targeted with win‑back campaigns, feedback forms or personalised discounts to increase their activity.

---

### 3. Products driving most revenue

- A small set of products contributes a large share of total revenue and appear again and again in customer orders.  
- These top products have both high order counts and strong total sales value.  
- Many other products sit in the long tail with much smaller revenue contribution.

**Takeaway:** Focus marketing and inventory on the top selling products, and review long tail products for bundling, discounting or even removing if they are not profitable.

---

### 4. Employee performance

- Some employees handle many more orders and generate more revenue than others.  
- When I rank employees by total revenue, a few clear top performers stand out.  
- A few employees are below average in both orders handled and revenue.

**Takeaway:** These metrics can be used for performance reviews, setting targets, doing coaching for low performers and learning best practices from top performers.

---

### 5. Regional and country sales

- Certain regions and countries bring in most of the company’s sales.  
- Average order value changes by region, which shows different purchasing power and product mix.  
- Some regions have low total sales but decent average order value, which could mean hidden growth opportunities.

**Takeaway:** Sales and marketing teams should double down on strong regions and design specific strategies for under‑penetrated but high potential markets.

---

### 6. Shipping performance

- Orders are not evenly distributed across shipping methods. Some shippers carry more volume than others.  
- Average delivery time changes by shipping method and some shippers are clearly faster and more consistent.  
- Slower shipping might be okay for low value orders but is risky for high value customers.

**Takeaway:** Use faster shipping methods for high value customers and orders, and work with slower shippers to improve service levels or change how we route orders to them.

---

### 7. Products at risk of stockout

- Some high demand products have low current inventory compared to their recent order volume.  
- These items are at real risk of stockout if demand continues at the same pace.  
- Other products have high inventory but low recent sales, which locks up capital in slow moving stock.

**Takeaway:** Create restock alerts for high demand / low stock items and review overstock items for discounts, bundles or supplier renegotiation.

---

### 8. Monthly sales trend

- Monthly sales show clear ups and downs over time instead of being flat.  
- Some months are consistently stronger in total sales and revenue than others.  
- This looks like seasonal behaviour or campaign driven spikes.

**Takeaway:** Use this pattern to plan inventory, staffing and campaigns. Push more marketing and stock into strong months and design offers to support slow months.

---

## Dataset

The project uses the classic Northwind sample database. It represents a trading company that sells food and beverage products around the world.

- 14 related tables like `Customers`, `Orders`, `Order Details`, `Products`, `Employees`, `Shippers` and more.  
- Rich relationships between customers, orders, products, suppliers and employees.  
- Great for practicing joins, aggregations, window functions and real world style SQL.

In my setup the Northwind schema is restored into PostgreSQL and I run all analysis directly with SQL queries.

---

## Tech Stack

- PostgreSQL 15  
- pgAdmin 4

---

## Project Structure

```text
northwind-sales-analysis/
├── insights/              # Notes and written insights from the analysis
├── queries/               # SQL scripts for each business question
├── .vscode/               # Editor configuration (optional)
├── .gitignore
├── LICENSE
└── README.md
```

---

## How to Run

1. Install PostgreSQL (15 or compatible) and pgAdmin 4.  
2. Restore the Northwind database into PostgreSQL using your Northwind SQL dump  
   (for example: `data/NORTHWIND-SALES-ANALYSIS.sql` if you add it to this repo).  
3. Open pgAdmin 4 and connect to your PostgreSQL server.  
4. Open the SQL files in the `queries` folder.  
5. Run the queries in order (`01_*.sql` to `08_*.sql`) to answer each business question.  
6. Check the outputs in pgAdmin and connect them with the insights written in this README.

---

## What I Practised

In this project I focused on:

- Writing clear SQL using CTEs, window functions and multi‑table joins.  
- Turning business questions into SQL queries and metrics.  
- Reading raw query results and converting them into simple business insights and action points.  
- Thinking like a junior data analyst supporting sales, operations and management teams.