-- ============================================================
-- Data Exploration
-- Analyze key date ranges and customer demographics
-- ============================================================


-- Explore the Sales Date Range
-- Identify the first and last order dates
-- Calculate the total number of months covered by the sales data
SELECT 
    MAX(order_date) AS first_order_date,
    MIN(order_date) AS last_order_date,
    DATEDIFF(
        MONTH,
        MIN(order_date),
        MAX(order_date)
    ) AS order_range_months
FROM gold.fact_sales;


-- Explore Customer Age Range
-- Identify the oldest and youngest customers based on birthdate
-- Calculate their approximate ages
SELECT 
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

