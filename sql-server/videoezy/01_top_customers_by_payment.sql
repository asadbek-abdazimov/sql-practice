-- Find the 10 customers who paid the most money in total.
-- Database: videoezy (SQL Server)
-- Concepts: JOIN, GROUP BY, SUM, ORDER BY, TOP


USE videoezy;
GO


SELECT TOP 10 
	c.customer_id, 
	c.first_name, 
	c.last_name,
	SUM(p.amount) AS total_payment
FROM customer c
JOIN payment p
	ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_payment DESC;