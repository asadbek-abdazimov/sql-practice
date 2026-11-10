-- For each customer, find the average number of days between their rentals.
-- Database: videoezy (SQL Server)
-- Concepts: CTE, JOIN, GROUP BY, COUNT, AVG, ROUND, CAST, ORDER BY

USE videoezy;
GO

WITH cte AS (
SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	r.rental_id,
	DATEDIFF(day, LAG(r.rental_date) OVER (PARTITION BY c.customer_id ORDER BY r.rental_date), r.rental_date) AS days_since_prev
FROM customer c
JOIN rental r
	ON c.customer_id = r.customer_id)
SELECT 
	customer_id,
	first_name,
	last_name,
	COUNT(rental_id) AS rental_count,
	CAST(ROUND(AVG(days_since_prev*1.0), 1) AS DECIMAL(5,1)) AS avg_days_between_rentals
FROM cte
GROUP BY customer_id, first_name, last_name
ORDER BY avg_days_between_rentals;
