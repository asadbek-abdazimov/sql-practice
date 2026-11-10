-- For each film category, show its total revenue and its percentage of all revenue.
-- Database: videoezy (SQL Server)
-- Concepts: CTE, JOIN, GROUP BY, SUM, CAST, WINDOW FUNCTIONS, ORDER BY

USE videoezy;
GO

WITH cte AS (
SELECT
	c.name AS category_name,
	SUM(p.amount) AS revenue
FROM category c
JOIN film_category fc
	ON c.category_id = fc.category_id
JOIN film f
	ON fc.film_id = f.film_id
JOIN inventory i
	ON f.film_id = i.film_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
JOIN payment p
	ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name)
SELECT
	category_name,
	revenue,
	CAST((revenue * 100.0 / (SUM(revenue) OVER())) AS DECIMAL(3, 1)) AS revenue_share_pct
FROM cte
ORDER BY revenue DESC;