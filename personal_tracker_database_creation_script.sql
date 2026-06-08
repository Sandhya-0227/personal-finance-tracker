CREATE DATABASE personal_finance_db;

CREATE TABLE categories (
	category_id INT NOT NULL,
	category_name VARCHAR(50),
	category_type VARCHAR(10),
	CONSTRAINT pk_categories PRIMARY KEY(category_id)
);

CREATE TABLE monthly_budget(
	budget_id INT NOT NULL,
	category_id INT NOT NULL,
	month_name DATE,
	budget_amount DECIMAL(10,2),
	CONSTRAINT pk_monthly_budget PRIMARY KEY(budget_id),
	CONSTRAINT fk_categories FOREIGN KEY(category_id) REFERENCES categories(category_id)
);

CREATE TABLE transactions(
	transaction_id INT NOT NULL,
	category_id INT,
	transaction_date DATE,
	amount DECIMAL(10,2),
	description VARCHAR(100),
	CONSTRAINT pk_transactions PRIMARY KEY(transaction_id)
);

CREATE TABLE savings_goal(
	goal_id INT NOT NULL,
	month_name DATE,
	target_savings DECIMAL(10,2),
	CONSTRAINT pk_savings_goal PRIMARY KEY(goal_id)
);

	





	

