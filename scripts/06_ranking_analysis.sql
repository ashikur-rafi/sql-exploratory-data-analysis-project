-- ============================================================
-- Ranking Analysis
-- Rank products, subcategories, and customers based on
-- revenue and order activity to identify top and bottom performers
-- ============================================================



-- Rank the Top 5 Products by Revenue
-- Identify the five products generating the highest total revenue
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key 
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- Rank the Top 5 Products Using a Window Function
-- Assign a ranking to products based on their total revenue
SELECT *
FROM (
    SELECT TOP 5
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY SUM(f.sales_amount) DESC
        ) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key 
    GROUP BY p.product_name
) t
WHERE rank_products <= 5;


-- Rank the Bottom 5 Products by Revenue
-- Identify the five products generating the lowest total revenue
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key 
GROUP BY p.product_name
ORDER BY total_revenue;


-- Rank the Top 5 Subcategories by Revenue
-- Identify the five subcategories generating the highest total revenue
SELECT TOP 5
    p.subcategory,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key 
GROUP BY p.subcategory
ORDER BY total_revenue DESC;


-- Rank the Bottom 5 Subcategories by Revenue
-- Identify the five subcategories generating the lowest total revenue
SELECT TOP 5
    p.subcategory,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key 
GROUP BY p.subcategory
ORDER BY total_revenue;


-- Rank the Bottom 3 Customers by Order Volume
-- Identify customers who placed the fewest number of orders
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders;


-- Rank the Top 10 Customers by Order Volume
-- Identify customers who placed the highest number of orders
SELECT TOP 10
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_orders DESC;

