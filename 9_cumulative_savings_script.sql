/*9. Running Total of Savings Across the Year
Show the cumulative savings month by month — like a running balance growing over 12 months. */

WITH monthly_summary AS (
	SELECT 
		DATENAME(MONTH,t.transaction_date) AS Month,
		MONTH(t.transaction_date) AS month_num,
		SUM(CASE WHEN c.category_type = 'Income' THEN t.amount ELSE 0 END) AS Total_income,
		SUM(CASE WHEN c.category_type = 'Expense' THEN t.amount ELSE 0 END) AS Total_expense
	FROM transactions t	
	JOIN categories c
	ON t.category_id = c.category_id
	GROUP BY DATENAME(MONTH,t.transaction_date), MONTH(t.transaction_date)
)
SELECT
	Month,
	month_num,
	Total_income, 
	Total_expense,
	Total_income - Total_expense AS Monthly_savings,
	SUM(Total_income - Total_expense) OVER(ORDER BY month_num) AS cumulative_savings
FROM monthly_summary
