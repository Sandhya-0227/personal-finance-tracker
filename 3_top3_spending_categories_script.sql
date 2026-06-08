/*3. Top 3 Spending Categories Overall
Which 3 categories consumed the most money across the entire year?*/

SELECT TOP 3
	c.category_name,
	SUM(t.amount) AS total_amount
FROM categories c
JOIN transactions t
ON c.category_id = t.category_id
WHERE c.category_type = 'Expense'
GROUP BY c.category_name
ORDER BY total_amount DESC;
