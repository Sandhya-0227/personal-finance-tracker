/*6. Months Where Expenses Exceeded Income
Find any month where the person spent more than they earned. */

WITH monthly_summary AS (
	SELECT
		DATENAME(MONTH,transaction_date) AS month,
		SUM(CASE WHEN category_type = 'Income' THEN amount ELSE 0 END) AS Total_income,
		SUM(CASE WHEN category_type = 'Expense' THEN amount ELSE 0 END) AS Total_expense
	FROM transactions AS t
	JOIN categories AS c
	ON t.category_id = c.category_id
	GROUP BY DATENAME(MONTH,transaction_date), MONTH(transaction_date)
)
SELECT 
	month,
	Total_income,
	Total_expense,
	Total_income - Total_expense AS balance_amount
FROM monthly_summary
WHERE Total_expense > Total_income