-- For each film category, find the 3 films that were rented the most times. If two films have the same number of rentals, give them the same rank.
-- Database: videoezy (PostgreSQL)
-- Concepts: CTE, JOIN, GROUP BY, COUNT, WINDOW FUNCTIONS, DENSE_RANK, WHERE, ORDER BY

WITH cte AS(
	SELECT 
		c.name AS category_name,
		f.title AS film_title,
		COUNT(r.rental_id) AS rental_count,
		DENSE_RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank
	FROM category c
	JOIN film_category fc USING(category_id)
	JOIN film f USING(film_id)
	JOIN inventory USING(film_id)
	JOIN rental r USING(inventory_id)
	GROUP BY c.category_id, c.name, f.film_id, f.title)
SELECT *
FROM cte
WHERE rank <=3
ORDER BY category_name, rank;