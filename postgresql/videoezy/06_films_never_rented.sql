-- Find all films that were never rented.
-- Database: videoezy (PostgreSQL)
-- Concepts: SUBQUERY, CASE, EXISTS, JOIN, WHERE, ORDER BY


SELECT 
	f.film_id,
	f.title AS film_title,
	CASE 
		WHEN EXISTS (SELECT 1 FROM inventory i WHERE f.film_id = i.film_id) THEN 'yes'
		ELSE 'no'
	END AS in_inventory
FROM film f
WHERE NOT EXISTS(
	SELECT 1
	FROM inventory i
	JOIN rental r
		ON i.inventory_id = r.inventory_id
	WHERE f.film_id = i.film_id)
ORDER BY film_title; 