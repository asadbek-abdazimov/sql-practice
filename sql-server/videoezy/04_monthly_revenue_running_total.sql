-- For each month, show the total revenue, the running total so far, and the change from the previous month.
-- Database: videoezy (SQL Server)
-- Concepts: CTE, GROUP BY, SUM, FORMAT, DATETRUNC, LAG, WINDOW FUNCTIONS, ORDER BY


USE videoezy;
GO

WITH cte AS (
SELECT 
	DATETRUNC(MONTH, payment_date) AS [month],
	SUM(amount) AS revenue
FROM payment
GROUP BY DATETRUNC(MONTH, payment_date))
SELECT 
	FORMAT([month], 'yyyy-MM') AS [month],
	revenue,
	SUM(revenue) OVER(ORDER BY [month]) AS running_total,
	(revenue - LAG(revenue) OVER( ORDER BY [month])) AS change_vs_prev_month
FROM cte
ORDER BY [month];