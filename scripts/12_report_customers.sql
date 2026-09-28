/*
=================================================================================
                              Customer Report
=================================================================================


Purpose:
    - This report consolidates key customer metrics and behaviors.

Highlights:
    1. Gathers essential customer information such as names, ages, and
       transaction details.

    2. Segments customers into categories:
       - VIP
       - Regular
       - New

    3. Groups customers into different age categories.

    4. Aggregates customer-level metrics:
       - Total orders
       - Total sales
       - Total quantity purchased
       - Total products
       - Customer lifespan (in months)

    5. Calculates valuable KPIs:
       - Recency (months since last order)
       - Average order value
       - Average monthly spend

=================================================================================
*/

CREATE VIEW gold.report_customers AS 

WITH base_query AS (

/*-------------------------------------------------------------------------------
1. Base Query
-------------------------------------------------------------------------------
Purpose:
    Retrieves the core customer and transaction-level information required
    for further aggregation and analysis.
-------------------------------------------------------------------------------
*/

SELECT 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,
DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key 
WHERE order_date IS NOT NULL   -- Only consider valid sales dates
)

, customer_aggregation AS (

/*-------------------------------------------------------------------------------
2. Customer Aggregations
-------------------------------------------------------------------------------
Purpose:
    Summarizes key sales and purchasing metrics at the customer level.

Metrics:
    - Total orders
    - Total sales
    - Total quantity purchased
    - Total products purchased
    - Last order date
    - Customer lifespan
-------------------------------------------------------------------------------
*/

SELECT
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) AS total_orders,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT product_key) AS total_products,
MAX(order_date) AS last_order_date,
DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query 
GROUP BY customer_key,
customer_number,
customer_name,
age
)

/*
===============================================================================
3. Final Query
===============================================================================
Purpose:
    Combines the aggregated customer metrics with customer segmentation,
    age grouping, and additional KPIs to create the final customer report.
===============================================================================
*/

SELECT
customer_key,
customer_number,
customer_name,
age,

/* Customer Age Group */
CASE 
	 WHEN age < 20 THEN 'Under 20'
	 WHEN age BETWEEN 20 AND 29 THEN '20 - 29'
	 WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
	 WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
	 ELSE '50 and above'
END AS age_group,

/* Customer Segmentation */
CASE
	 WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
	 WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
	 ELSE 'New'
END AS customer_segment,

total_orders,
total_sales,
total_quantity,
total_products,
last_order_date,

/* Recency: Number of months since the customer's last order */
DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,

lifespan,

/* Compute Average Order Value */
CASE WHEN total_orders = 0 THEN 0
     ELSE total_sales/total_orders 
END AS avg_order_value,

/* Compute Average Monthly Spend */
CASE WHEN lifespan = 0 THEN total_sales
	 ELSE total_sales / lifespan
END AS average_monthly_spend 

FROM customer_aggregation

