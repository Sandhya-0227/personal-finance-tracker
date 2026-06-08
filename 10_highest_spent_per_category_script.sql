/*10. Highest Single Transaction per Category
Find the biggest one-time spend in each expense category across the year. */

SELECT 
	category_name,
	MAX(amount) AS highest_spent
FROM transactions t
JOIN categories c
ON t.category_id = c.category_id
WHERE category_type = 'Expense'
GROUP BY category_name
ORDER BY highest_spent DESC;