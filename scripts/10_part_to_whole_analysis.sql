-- ============================================================
-- Part-to-Whole Analysis
-- Analyze how each product category contributes to overall sales
-- and determine its percentage share of total revenue
-- ============================================================

-- Analyze Sales Contribution by Category
-- Compare category-level sales against total sales
-- to identify each category's contribution to overall revenue
WITH category_sales AS (
    SELECT
        category,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY category
)

SELECT
    category,
    total_sales,

    -- Calculate overall sales across all categories
    SUM(total_sales) OVER () AS overall_sales,

    -- Calculate each category's percentage contribution
    CONCAT(
        ROUND(
            (CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100,
            2
        ),
        '%'
    ) AS percentage_of_total

FROM category_sales
ORDER BY total_sales DESC;
