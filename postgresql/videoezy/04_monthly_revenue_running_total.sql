-- For each month, show the total revenue, the running total so far, and the change from the previous month.
-- Database: videoezy (PostgreSQL)
-- Concepts: CTE, GROUP BY, SUM, TO_CHAR, DATE_TRUNC, LAG, WINDOW FUNCTIONS, ORDER BY


WITH cte AS (
SELECT 
	DATE_TRUNC('MONTH', payment_date) AS month,
	SUM(amount) AS revenue
FROM payment
GROUP BY DATE_TRUNC('MONTH', payment_date))
SELECT 
	TO_CHAR(month, 'yyyy-MM') AS month,
	revenue,
	SUM(revenue) OVER (ORDER BY month) AS running_total,
	(revenue - LAG(revenue) OVER (ORDER BY month)) AS change_vs_prev_month
FROM cte
ORDER BY month;