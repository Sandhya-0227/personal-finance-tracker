/*1. Total Income vs Total Expenses per Month
Find how much was earned and spent each month across all of 2024.*/

SELECT
	DATENAME(MONTH,transaction_date) AS Month,
	SUM(CASE WHEN category_type = 'Income' THEN amount ELSE 0 END) AS Total_income,
	SUM(CASE WHEN category_type = 'Expense' THEN amount ELSE 0 END) AS Total_expense
FROM transactions AS t
JOIN categories AS c
ON t.category_id = c.category_id
GROUP BY DATENAME(MONTH,transaction_date), MONTH(transaction_date)
ORDER BY MONTH(transaction_date)
 






