# 📊 SQL Exploratory Data Analysis Project

> 🧠 Exploring data. 🔍 Uncovering patterns. 📊 Turning SQL queries into insights.

## 📌 Project Overview

This project demonstrates an end-to-end **Exploratory Data Analysis (EDA)** workflow using **Microsoft SQL Server**.

The goal is to transform raw sales data into meaningful business insights through SQL-based data exploration, aggregation, segmentation, and KPI analysis.

The project focuses on understanding **customer behavior, product performance, sales trends, and overall business performance** using a structured analytical approach.

---

## 🎯 Objectives

The main objectives of this project are to:

* Explore and understand the structure of the dataset.
* Analyze sales performance and business trends.
* Identify customer purchasing patterns.
* Analyze product and category performance.
* Segment customers based on spending behavior and purchasing history.
* Segment products based on cost and revenue performance.
* Calculate important business KPIs.
* Create reusable analytical views for reporting.
* Practice writing clean, structured, and efficient SQL queries.

---

## 🛠️ Tools & Technologies

| Tool           | Purpose                                                     |
| -------------- | ----------------------------------------------------------- |
| **SQL Server** | Database management and data analysis                       |
| **SSMS**       | SQL development and query execution                         |
| **SQL**        | Data exploration, transformation, aggregation, and analysis |
| **Git**        | Version control                                             |
| **GitHub**     | Project documentation and portfolio                         |

---

## 📂 Project Structure

```text
sql-exploratory-data-analysis-project/
│
├── datasets/
│   └── Raw datasets used for the analysis
│
├── docs/
│   └── Project documentation and supporting materials
│
├── scripts/
│   └── SQL scripts for exploratory analysis and reporting
│
├── README.md
└── LICENSE
```

---

## 🔍 Analysis Covered

### 1. Database Exploration

Initial exploration is performed to understand:

* Available tables
* Table structures
* Columns and data types
* Relationships between datasets
* Overall data availability

---

### 2. Dimension Exploration

The project explores important business dimensions such as:

* Customers
* Products
* Categories
* Subcategories
* Customer demographics

This provides the foundation for further analysis.

---

### 3. Date & Time Analysis

Date-based analysis is used to understand:

* Sales over time
* Yearly trends
* Monthly trends
* Customer purchasing lifespan
* Product selling lifespan
* Recency

---

### 4. Measures & Business KPIs

Key business metrics are calculated using SQL, including:

* Total Sales
* Total Orders
* Total Quantity Sold
* Total Customers
* Total Products
* Average Order Value
* Average Selling Price
* Average Monthly Revenue
* Average Monthly Customer Spending
* Customer Recency

---

### 5. Magnitude Analysis

The project analyzes business performance across different dimensions, including:

* Product categories
* Product subcategories
* Customers
* Products
* Sales

This helps identify where sales volume and revenue are concentrated.

---

### 6. Ranking Analysis

SQL ranking techniques are used to identify:

* Top-performing products
* Lowest-performing products
* Top customers
* Products generating the highest revenue
* Categories and subcategories with significant sales

Techniques include:

* `RANK()`
* `DENSE_RANK()`
* `ROW_NUMBER()`
* Aggregation functions

---

### 7. Part-to-Whole Analysis

The project analyzes how individual categories contribute to overall sales.

For example:

```text
Category Sales
      ↓
Total Sales
      ↓
Percentage Contribution
```

This helps understand the relative contribution of different product categories to total business sales.

---

### 8. Data Segmentation

Products and customers are divided into meaningful groups.

#### Product Cost Segmentation

Products are grouped into cost ranges such as:

* Below 100
* 100–500
* 500–1000
* Above 1000

#### Customer Segmentation

Customers are classified based on spending and purchasing history:

| Segment     | Criteria                                                  |
| ----------- | --------------------------------------------------------- |
| **VIP**     | At least 12 months of history and spending above $5,000   |
| **Regular** | At least 12 months of history and spending $5,000 or less |
| **New**     | Less than 12 months of history                            |

---

## 📊 Customer Report

A reusable customer reporting view is created to consolidate customer-level information and KPIs.

The report includes:

* Customer ID
* Customer number
* Customer name
* Age
* Age group
* Customer segment
* Total orders
* Total sales
* Total quantity
* Total products
* Last order date
* Recency
* Customer lifespan
* Average Order Value
* Average Monthly Spend

### Customer Segmentation

```text
Customer
   │
   ├── VIP
   │
   ├── Regular
   │
   └── New
```

---

## 📦 Product Report

A reusable product reporting view is also created to analyze product-level performance.

The report includes:

* Product ID
* Product name
* Category
* Subcategory
* Cost
* Last sale date
* Recency
* Product segment
* Product lifespan
* Total orders
* Total sales
* Total quantity
* Total customers
* Average selling price
* Average Order Revenue
* Average Monthly Revenue

### Product Performance Segmentation

Products are classified based on total sales:

```text
Total Sales
    │
    ├── High Performer
    │
    ├── Mid Range
    │
    └── Low Performer
```

---

## 🧠 SQL Techniques Used

This project demonstrates practical use of:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `JOIN`
* `LEFT JOIN`
* `CASE`
* `CTE`
* Aggregate functions
* Window functions
* `RANK()`
* `ROW_NUMBER()`
* `DENSE_RANK()`
* `DATEDIFF()`
* `DATEPART()`
* `CONCAT()`
* `CAST()`
* `ROUND()`
* `NULLIF()`
* `COALESCE()`
* `COUNT(DISTINCT ...)`
* Subqueries
* SQL Views

---

## 📈 Key Analytical Questions

The analysis is designed to answer questions such as:

* What are the overall sales and order volumes?
* Which products generate the most revenue?
* Which products have lower sales performance?
* Which categories contribute the most to total sales?
* Who are the highest-spending customers?
* How long have customers been purchasing?
* How recently have customers purchased?
* How are customers distributed across different segments?
* How are products distributed across different cost ranges?
* What is the average order value?
* What is the average monthly revenue generated by products?
* What is the average monthly spending of customers?

---

## 📁 SQL Scripts

The SQL scripts are organized inside the `scripts/` directory.

They cover different stages of the analysis, from basic exploration to advanced analytical queries and reporting views.

```text
scripts/
│
├── Exploration
├── Dimensions
├── Date Analysis
├── Measures & KPIs
├── Magnitude Analysis
├── Ranking Analysis
├── Part-to-Whole Analysis
├── Segmentation
└── Reports
```

---

## 🚀 Learning Outcomes

Through this project, I practiced how to:

* Work with relational databases using SQL Server.
* Explore and understand real-world datasets.
* Translate business questions into SQL queries.
* Use CTEs to structure complex queries.
* Apply aggregation and window functions.
* Perform customer and product segmentation.
* Build reusable SQL views.
* Calculate business-focused KPIs.
* Organize SQL projects professionally using Git and GitHub.
* Document analytical work clearly.

---

## 🔮 Future Improvements

Potential future improvements include:

* Building interactive dashboards using **Power BI**.
* Adding additional customer retention analysis.
* Performing cohort analysis.
* Adding more advanced time-series analysis.
* Creating additional reporting views.
* Connecting the SQL database to a BI dashboard.
* Expanding the project with more business questions and analytical scenarios.

---

## 👨‍💻 Author

**Md. Asikur Rahman **

Aspiring **Data Analyst** focused on SQL, Excel, Python, Power BI, and data-driven problem-solving.

### 🔗 Connect With Me

* GitHub: [@ashikur-rafi](https://github.com/ashikur-rafi)

---

## 📄 License

This project is licensed under the **MIT License**.



