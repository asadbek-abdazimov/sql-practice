-- Show a table: one row per category, and one column per store, with the number of rentals in each cell.
-- Database: videoezy (SQL Server)
-- Concepts: PIVOT, CONDITIONAL AGGREGATION, JOIN, GROUP BY, SUM, COUNT, CASE, ORDER BY


USE videoezy;
GO

SELECT 
	c.name AS category_name,
	SUM(CASE WHEN i.store_id = 1 THEN 1 ELSE 0 END) AS store_1,
	SUM(CASE WHEN i.store_id = 2 THEN 1 ELSE 0 END) AS store_2,
	COUNT(r.rental_id) AS total
FROM category c
JOIN film_category fc
	ON c.category_id = fc.category_id
JOIN inventory i
	ON fc.film_id = i.film_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
ORDER BY total DESC;