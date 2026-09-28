/*
==============================================================================
                              Product Report
==============================================================================

Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential product information such as product name, category,
       subcategory, and cost.

    2. Segments products by revenue to identify:
       - High-Performers
       - Mid-Range
       - Low-Performers

    3. Aggregates product-level metrics:
       - Total orders
       - Total sales
       - Total quantity sold
       - Total customers (unique)
       - Product lifespan (in months)

    4. Calculates valuable KPIs:
       - Recency (months since last sale)
       - Average Order Revenue (AOR)
       - Average Monthly Revenue (AMR)

==============================================================================
*/

CREATE VIEW gold.report_products AS

WITH base_query AS (

/*
==============================================================================
1. Base Query
==============================================================================
Purpose:
    Retrieves the core product and transaction-level information from the
    fact_sales and dim_products tables for further analysis.
==============================================================================
*/

SELECT 
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key 
WHERE order_date IS NOT NULL  -- Only consider valid sales dates
),

product_aggregations AS ( 

/*
------------------------------------------------------------------------------
2. Product Aggregations
------------------------------------------------------------------------------
Purpose:
    Summarizes key sales and purchasing metrics at the product level.

Metrics:
    - Product lifespan
    - Last sale date
    - Total orders
    - Total customers
    - Total sales
    - Total quantity sold
    - Average selling price
------------------------------------------------------------------------------
*/

SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
FROM base_query

GROUP BY product_key,
	product_name,
	category,
	subcategory,
	cost
)

/*
==============================================================================
3. Final Query
==============================================================================
Purpose:
    Combines all product-level metrics with product segmentation and
    additional KPIs to create the final product report.
==============================================================================
*/

SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,

	/* Recency: Number of months since the product was last sold */
	DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,

	/* Product Segmentation Based on Total Sales */
	CASE 
		 WHEN total_sales > 50000 THEN 'High_Performer'
		 WHEN total_sales >= 10000 THEN 'Mid_Range'
		 ELSE 'Low_performer'
    END AS product_segment,

	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,

	/* Average Order Revenue (AOR) */
	CASE 
		 WHEN total_orders = 0 THEN 0
		 ELSE total_sales / total_orders 
	END AS avg_order_revenue,

	/* Average Monthly Revenue (AMR) */
	CASE 
		 WHEN lifespan = 0 THEN total_sales
		 ELSE total_sales / lifespan
	END AS avg_monthly_revenue
	
FROM product_aggregations

