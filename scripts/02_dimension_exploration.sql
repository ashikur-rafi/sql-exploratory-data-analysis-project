-- ============================================================
-- Dimension Exploration
-- Explore key attributes within customer and product dimensions
-- ============================================================


-- Explore All Countries Our Customers Come From
-- Identify the unique countries represented in the customer dimension
SELECT DISTINCT country
FROM gold.dim_customers;


-- Explore Product Categories & Subcategories
-- Examine the hierarchy of major product divisions
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY 1, 2, 3;

