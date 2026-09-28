-- ============================================================
-- Cumulative Analysis
-- Analyze cumulative sales performance and pricing trends
-- over time using window functions
-- ============================================================



-- Calculate Monthly Sales and Cumulative Performance
-- Calculate total sales per month
-- Track the running total of sales over time
-- Calculate the moving average of product prices
SELECT 
    order_date,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY order_date
    ) AS running_total_sales,
    AVG(avg_price) OVER (
        ORDER BY order_date
    ) AS moving_avg_price
FROM (
    SELECT 
        DATETRUNC(MONTH, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
) t;

