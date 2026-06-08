/*7. Category-wise Overspending Frequency
How many months did each expense category go over its budget? (e.g., Shopping exceeded budget 7 out of 12 months) */

WITH planned_budget AS (
	SELECT 
		category_id,
		DATENAME(MONTH,month_name) AS Month,
		MONTH(month_name) AS month_num,
		budget_amount AS planned_amount
	FROM monthly_budget
),
actual_amount AS (
	SELECT 
		category_id,
		DATENAME(MONTH,transaction_date) AS Month,
		MONTH(transaction_date) AS month_num,
		SUM(amount) AS spent_amount
	FROM transactions
	GROUP BY 
		category_id,
		DATENAME(MONTH,transaction_date),
		MONTH(transaction_date)
),
overly_spent_amount AS (
	SELECT 
		p.Month,
		p.category_id,
		c.category_name,
		p.planned_amount,
		a.spent_amount,
		a.spent_amount - p.planned_amount AS overly_spent
	FROM planned_budget p
	JOIN actual_amount a
	ON p.category_id = a.category_id AND a.month_num = p.month_num
	JOIN categories c
	ON p.category_id = c.category_id
	WHERE c.category_type = 'Expense' AND spent_amount > planned_amount
	
)
SELECT 
	category_name,
	COUNT(Month) AS overspent_months
FROM overly_spent_amount
GROUP BY category_name
ORDER BY overspent_months DESC;

