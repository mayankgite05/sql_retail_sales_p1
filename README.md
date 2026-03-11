# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a query to retreive all columns for sales made on '2022-11-05'**:
```sql
SELECT * FROM retail_sales
	WHERE sale_date = '2022-11-05';
```

2. **Write a query to retreive all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT* 
	FROM retail_sales
	WHERE category = 'Clothing' 
	AND 
	TO_CHAR(sale_date, 'YYYY-DD') = '2022-11'
	AND
	quantity >= 4
	;
```

3. **Write a query to calculate the total sales (total_sale) for each category**:
```sql
SELECT category,
	SUM(total_sale) AS totalsales
	FROM retail_sales
	GROUP BY category
	;
```

4. **Write a query to find the average age of the customers who purchased items from the 'Beauty' category**:
```sql
SELECT 
	ROUND(AVG(age)) AS avg_age
	FROM retail_sales
	WHERE category = 'Beauty'
	;
```

5. **Write a query to find the total number of transactions where the total_sale is greater than 1000**:
```sql
SELECT
	COUNT(transactions_id) AS transacn_number 
	FROM retail_sales
	WHERE total_sale > 1000
	;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
	category,
	gender,
	COUNT(*) AS total_trans
	FROM retail_sales
	GROUP BY category, gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sales,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY year, month
ORDER by year, avg_sales DESC;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, 
	SUM(total_sale) AS total_sales
	FROM retail_sales
	GROUP BY customer_id
	ORDER BY total_sales DESC
	LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category,
	COUNT (DISTINCT customer_id) AS ct_uq_cs
	FROM retail_sales
	GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```
**##Problem**

Retail businesses often struggle to analyze sales data effectively to identify trends, customer behavior, and performance metrics.
The dataset contains information about transactions, customers, categories, sales amounts, and timestamps, but raw data alone doesn’t provide actionable insights.
The goal is to use SQL queries to answer key business questions such as:
- Which products/categories sell the most?
- Who are the top customers?
- Which month/year performs best?

## Findings

- Daily & Monthly Trends: Sales can be tracked by day and month, revealing seasonal peaks and best-performing months.
- Category Insights: Clothing shows bulk purchases; Beauty attracts a distinct age group; high-value sales (>1000) highlight premium buying behavior.
- Customer Analysis: Top 5 customers contribute disproportionately to revenue; unique customer counts show category reach.
- Demographics & Gender: Gender-based transaction splits uncover buying preferences across categories.
- Shift Analysis: Morning, Afternoon, and Evening sales patterns highlight peak shopping hours for resource planning.

## Conclusion

SQL-driven analysis turns raw retail data into strategic insights. Businesses can leverage these findings to:
- Optimize inventory around high-demand categories and peak months.
- Target marketing toward top customers and specific demographics.
- Improve operations by aligning staffing and promotions with peak shopping hours.
This project demonstrates how data analysis influence smarter retail decisions, and sets the stage for advanced dashboards and predictive analytics.

## Author - Mayank Gite
- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/mayank-gite-45373a144)


This SQL project showcases my ability to turn raw data into actionable decisions and insights by analyzing data through SQL queries in PostgreSQL. 
If you're looking for a data -driven professional who can bridge the gap between numbers and insights/decisions, let's connect to know more details about my experience!

