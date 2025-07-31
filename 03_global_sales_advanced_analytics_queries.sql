-- Global Sales Advanced Analytics Queries
-- Author: Muhammed Mufinuddin Afraz
-- Description: SQL queries for analyzing 1M+ sales transactions
-- Includes:
-- 1. Monthly Revenue by Region
-- 2. Top Countries by Profit
-- 3. Product Performance
-- 4. Revenue Category Distribution
-- 5. Yearly Growth
-- 6. Average Profit Margin
-- 7. Top Transactions
CREATE DATABASE global_sales_db;
USE global_sales_db;

CREATE TABLE sales_transactions (
    transaction_id BIGINT PRIMARY KEY,
    date DATE,
    region VARCHAR(50),
    country VARCHAR(50),
    product VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    cost DECIMAL(10,2),
    revenue DECIMAL(12,2),
    profit DECIMAL(12,2),
    year INT,
    month INT,
    profit_margin DECIMAL(5,2),
    revenue_category VARCHAR(20)
)
TRUNCATE TABLE sales_transactions;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/global_sales_transactions_2023_2024_cleaned_mysql.csv'
INTO TABLE sales_transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, date, region, country, product, quantity, unit_price, cost, revenue, profit, year, month, profit_margin, revenue_category);

SELECT COUNT(*) FROM sales_transactions;

SELECT
    year,
    month,
    region,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM
    sales_transactions
GROUP BY
    year, month, region
ORDER BY
    year, month, region;

SELECT
    country,
    ROUND(SUM(profit), 2) AS total_profit
FROM
    sales_transactions
GROUP BY
    country
ORDER BY
    total_profit DESC
LIMIT 10;

SELECT
    product,
    COUNT(*) AS transactions,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit
FROM
    sales_transactions
GROUP BY
    product
ORDER BY
    total_revenue DESC;

SELECT
    revenue_category,
    COUNT(*) AS transactions,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM
    sales_transactions
GROUP BY
    revenue_category
ORDER BY
    total_revenue DESC;
SELECT
    year,
    region,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM
    sales_transactions
GROUP BY
    year, region
ORDER BY
    year, region;
SELECT
    product,
    ROUND(AVG(profit_margin)*100, 2) AS avg_profit_margin_pct
FROM
    sales_transactions
GROUP BY
    product
ORDER BY
    avg_profit_margin_pct DESC;
SELECT
    transaction_id,
    date,
    country,
    product,
    revenue
FROM
    sales_transactions
ORDER BY
    revenue DESC
LIMIT 10;

