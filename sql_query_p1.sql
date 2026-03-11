-- SQL Retail Sales Analysis - P1

DROP TABLE IF
CREATE TABLE retail_sales_tb(
					transactions_id	INT PRIMARY KEY,
					sale_date date,
					sale_time TIME,
					customer_id INT,	
					gender VARCHAR (10),	
					age INT,
					category VARCHAR(20),
					quantiy	INT,
					price_per_unit FLOAT,
					cogs FLOAT,
					total_sale FLOAT
			);

CREATE DATABASE sql_project_p1;

SELECT * FROM retail_sales;

SELECT COUNT(*) 
FROM retail_sales;

-- DATA EXPLORATION

-- What is the sales count?
SELECT COUNT(*) AS total_sales
FROM retail_sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- How many unique categories we have?
SELECT COUNT(DISTINCT category) AS unique_categories FROM retail_sales;

-- DATA ANALYSIS & KEY BUSINESS PROBLEMS
-- Q1. Write a query to retreive all columns for sales made on '2022-11-05'
	SELECT * FROM retail_sales
	WHERE sale_date = '2022-11-05';
-- Q2. Write a query to retreive all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
	SELECT* 
	FROM retail_sales
	WHERE category = 'Clothing' 
	AND 
	TO_CHAR(sale_date, 'YYYY-DD') = '2022-11'
	AND
	quantity >= 4
	;
-- Q3. Write a query to calculate the total sales (total_sale) for each category.
	SELECT category,
	SUM(total_sale) AS totalsales
	FROM retail_sales
	GROUP BY category
	;
-- Q4. Write a query to find the average age of the customers who purchased items from the 'Beauty' category
	SELECT 
	ROUND(AVG(age)) AS avg_age
	FROM retail_sales
	WHERE category = 'Beauty'
	;
-- Q5. Write a query to find the total number of transactions where the total_sale is greater than 1000
	SELECT
	*
	FROM retail_sales
	WHERE total_sale > 1000
	;
-- Q6. Write a query to find the total number of transactions (transactions_id) made by each gender in each category
	SELECT 
	category,
	gender,
	COUNT(*) AS total_trans
	FROM retail_sales
	GROUP BY category, gender;
-- Q7. Write a query to calculate the average sale for each month. Find out best selling month in each year
	SELECT 
	EXTRACT(YEAR FROM sale_date) AS year,
	EXTRACT(MONTH FROM sale_date) AS month,
	ROUND(AVG (total_sale)) AS avg_sales
	FROM retail_sales
	GROUP BY year, month
	ORDER BY year, avg_sales DESC;   
-- Q8. Write a query to find the top 5 customers based on the highest total sales.
	SELECT customer_id, 
	SUM(total_sale) AS total_sales
	FROM retail_sales
	GROUP BY customer_id
	ORDER BY total_sales DESC
	LIMIT 5;
-- Q9. Write a query to find the number of unique customers who purchased items from each category.
	SELECT category,
	COUNT (DISTINCT customer_id) AS ct_uq_cs
	FROM retail_sales
	GROUP BY category;
-- Q10. Write a query to create each shift and number of orders (Example morning <=12, Afternoon Between 12 & 17, Evening > 17)
	WITH hourly_sale 
	AS
	(
	SELECT*,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS Shift
	FROM retail_sales
	)

	SELECT
	shift,
	COUNT(transactions_id) AS trans_count
	FROM hourly_sale
	GROUP BY shift;
	