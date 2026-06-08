/* 8. Savings Rate per Month (as a percentage)
Savings Rate = (Savings / Income) × 100. Show this for each month to spot good and bad months.*/

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
),
monthly_savings AS (
	SELECT
		Month,
		month_num,
		Total_income, 
		Total_expense,
		Total_income - Total_expense AS Monthly_savings
	FROM monthly_summary
)
SELECT 
	Month,
	Total_income, 
	Total_expense,
	ROUND((Monthly_savings / Total_income) * 100.0,2) AS Savings_Rate
FROM monthly_savings
ORDER BY month_num;