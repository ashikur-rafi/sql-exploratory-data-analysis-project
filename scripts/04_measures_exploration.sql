-- ============================================================
-- Measures Exploration
-- Calculate key business metrics to understand overall
-- sales performance, products, customers, and order activity
-- ============================================================


-- Calculate Total Sales
SELECT 
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales;


-- Calculate Total Quantity of Items Sold
SELECT 
    SUM(quantity) AS total_quantity
FROM gold.fact_sales;


-- Calculate Average Selling Price
SELECT 
    AVG(price) AS avg_price
FROM gold.fact_sales;


-- Calculate Total Number of Orders
-- Use DISTINCT to avoid counting duplicate order lines
SELECT 
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;


-- Calculate Total Number of Products
-- Use DISTINCT product_key to count unique products
SELECT 
    COUNT(DISTINCT product_key) AS total_products
FROM gold.dim_products;


-- Calculate Total Number of Customers
-- Use DISTINCT customer_key to count unique customers
SELECT 
    COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customers;


-- Calculate Total Number of Customers Who Have Placed an Order
-- Count unique customers appearing in the sales transactions
SELECT 
    COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales;


-- ============================================================
-- Generate a Summary Report of Key Business Metrics
-- Combine the main KPIs into a single result set
-- for a quick overview of overall business performance
-- ============================================================

SELECT 
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Quantity',
    SUM(quantity)
FROM gold.fact_sales

UNION ALL

SELECT 
    'Average Price',
    AVG(price)
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Nr. Orders',
    COUNT(DISTINCT order_number)
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Nr. Products',
    COUNT(DISTINCT product_key)
FROM gold.dim_products

UNION ALL

SELECT 
    'Total Nr. Customers',
    COUNT(DISTINCT customer_key)
FROM gold.dim_customers;

