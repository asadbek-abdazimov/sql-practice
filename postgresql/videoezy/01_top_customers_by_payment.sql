-- Find the 10 customers who paid the most money in total.
-- Database: videoezy (PostgreSQL)
-- Concepts: JOIN, GROUP BY, SUM, ORDER BY, LIMIT


SELECT 
	c.customer_id, 
	c.first_name, 
	c.last_name,
	SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p USING(customer_id)
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_payment DESC
LIMIT 10;
