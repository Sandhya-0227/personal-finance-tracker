/*5. Monthly Savings Goal vs Actual Savings
Compare the target savings from savings_goal table against the actual savings you calculated. */

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
	m.Month,
	Monthly_savings,
	target_savings,
	Monthly_savings - target_savings AS savings_gap
FROM savings_goal s
JOIN monthly_savings m
ON MONTH(s.month_name) = m.month_num
ORDER BY m.month_num;


	