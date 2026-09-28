-- ============================================================
-- Change Over Time (Trends)
-- Analyze sales performance and business activity over time
-- ============================================================



-- Analyze Monthly Sales Trends
-- Track total sales, unique customers, and quantity sold
-- across each year and month
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
    YEAR(order_date),
    MONTH(order_date)
ORDER BY 
    YEAR(order_date),
    MONTH(order_date);


-- Analyze Monthly Trends Using Formatted Dates
-- Format the order date as Year-Month for easier readability
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');


-- Analyze Monthly Trends Using DATETRUNC
-- Truncate order dates to the beginning of each month
-- to create a clean and consistent time-based analysis
SELECT
    DATETRUNC(MONTH, order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date);

