-- ============================================================
-- Database Exploration
-- Explore database objects and understand the available schema
-- ============================================================

-- Explore All Tables in the Database
SELECT *
FROM INFORMATION_SCHEMA.TABLES;


-- Explore All Columns in the Database
-- Filtered to inspect the structure of the dim_customers table
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

