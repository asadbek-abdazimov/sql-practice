-- For each film category, count how many films it has and find the average rental rate.
-- Database: videoezy (SQL Server)
-- Concepts: JOIN, GROUP BY, COUNT, AVG, ROUND, ORDER BY

USE videoezy;
GO

SELECT 
	c.name AS category_name,
	COUNT(f.film_id) AS film_count,
	ROUND(AVG(f.rental_rate),2) AS avg_rental_rate
FROM category c
JOIN film_category fc
	ON c.category_id = fc.category_id
JOIN film f
	ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC
