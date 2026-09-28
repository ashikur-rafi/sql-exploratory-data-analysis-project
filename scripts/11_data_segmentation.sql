/*
===============================================================================
                         DATA SEGMENTATION
===============================================================================

This section focuses on segmenting products and customers into meaningful
groups based on product cost and customer spending behavior.

Analyses included:
    1. Product Segmentation by Cost Range
    2. Customer Segmentation by Spending Behavior

===============================================================================
*/



/*
===============================================================================
1. PRODUCT SEGMENTATION BY COST RANGE
===============================================================================

Purpose:
    Segment products into different cost ranges and count how many products
    fall into each segment.

Segmentation Criteria:
    - Below 100  : Cost less than 100
    - 100-500    : Cost between 100 and 500
    - 500-1000   : Cost between 500 and 1000
    - Above 1000 : Cost greater than 1000

===============================================================================
*/

WITH product_segments AS (
SELECT
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'Below 100'
	 WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	 WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	 ELSE 'Above 1000'
END AS cost_range
FROM gold.dim_products)

SELECT 
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


/*
===============================================================================
2. CUSTOMER SEGMENTATION BY SPENDING BEHAVIOR
===============================================================================

Purpose:
    Group customers into three segments based on their spending behavior
    and purchasing history, then find the total number of customers
    in each segment.

Segmentation Criteria:
    - VIP:
        Customers with at least 12 months of history and spending
        more than $5,000.

    - Regular:
        Customers with at least 12 months of history and spending
        $5,000 or less.

    - New:
        Customers with a lifespan of less than 12 months.

===============================================================================
*/

WITH customer_spending AS (
SELECT 
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_name,
MAX(order_date) AS last_name,
DATEDIFF (month, MIN(order_date), MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key
)
SELECT 
customer_segment,
COUNT(customer_key) total_customers
FROM(
	SELECT 
	customer_key,
	CASE WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
		 WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
		 ELSE 'New'
	END AS customer_segment
	FROM customer_spending ) t 
GROUP BY customer_segment
ORDER BY total_customers DESC;

