-- Put customers into 4 groups by total payment: top 25% = "Gold", next = "Silver", then "Bronze", lowest = "Basic". Then count the customers and the total revenue in each group.
-- Database: videoezy (PostgreSQL)
-- Concepts: CTE, JOIN, GROUP BY, SUM, COUNT, AVG, WINDOW FUNCTIONS, CASE, ORDER BY


WITH cte AS (
SELECT
	c.customer_id,
	SUM(p.amount) AS revenue
FROM customer c
JOIN payment p USING(customer_id)
GROUP BY c.customer_id),
cte2 AS (
SELECT
	NTILE(4) OVER (ORDER BY revenue DESC) AS num,
	customer_id,
	revenue
FROM cte),
cte3 AS (
SELECT 
	num,
	CASE
		WHEN num = 1 THEN 'Gold'
		WHEN num = 2 THEN 'Silver'
		WHEN num = 3 THEN 'Bronze'
		ELSE 'Basic'
	END AS segment,
	customer_id,
	revenue
FROM cte2)
SELECT
	segment,
	COUNT(customer_id) AS customer_count,
	SUM(revenue) AS total_revenue,
	AVG(revenue):: DECIMAL(7,2) AS avg_revenue_per_customer
FROM cte3
GROUP BY segment, num
ORDER BY num;
