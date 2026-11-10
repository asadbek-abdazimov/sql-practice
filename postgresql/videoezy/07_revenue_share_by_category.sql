-- For each film category, show its total revenue and its percentage of all revenue.
-- Database: videoezy (PostgreSQL)
-- Concepts: CTE, JOIN, GROUP BY, SUM, CAST, WINDOW FUNCTIONS, ORDER BY

WITH cte AS (
SELECT
	c.name AS category_name,
	SUM(p.amount) AS revenue
FROM category c
JOIN film_category fc USING(category_id)
JOIN film f USING(film_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
JOIN payment p USING(rental_id)
GROUP BY c.category_id, c.name)
SELECT
	category_name,
	revenue,
	CAST((revenue * 100.0 / (SUM(revenue) OVER())) AS DECIMAL(3, 1)) AS revenue_share_pct
FROM cte
ORDER BY revenue DESC;