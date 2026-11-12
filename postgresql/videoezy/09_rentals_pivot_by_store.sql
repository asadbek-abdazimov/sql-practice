-- Show a table: one row per category, and one column per store, with the number of rentals in each cell.
-- Database: videoezy (PostgreSQL)
-- Concepts: PIVOT, CONDITIONAL AGGREGATION, JOIN, GROUP BY, SUM, COUNT, CASE, ORDER BY


SELECT
	c.name AS category_name,
	SUM(CASE WHEN i.store_id = 1 THEN 1 ELSE 0 END) AS store_1,
	SUM(CASE WHEN i.store_id = 2 THEN 1 ELSE 0 END) AS store_2,
	COUNT(r.rental_id) AS total
FROM category c
JOIN film_category fc USING(category_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
GROUP BY c.category_id, c.name
ORDER BY total DESC;