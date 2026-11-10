-- For each customer, find the average number of days between their rentals.
-- Database: videoezy (PostgreSQL)
-- Concepts: CTE, JOIN, GROUP BY, COUNT, AVG, ROUND, ORDER BY

WITH cte AS(
SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	r.rental_id,
	(r.rental_date::DATE - LAG(r.rental_date) OVER (PARTITION BY c.customer_id ORDER BY r.rental_date)::DATE) AS days_since_prev
FROM customer c
JOIN rental r USING(customer_id))
SELECT 
	customer_id,
	first_name,
	last_name,
	COUNT(rental_id) AS rental_count,
	ROUND(AVG(days_since_prev),1) AS avg_days_between_rentals
FROM cte
GROUP BY customer_id, first_name, last_name
ORDER BY avg_days_between_rentals;