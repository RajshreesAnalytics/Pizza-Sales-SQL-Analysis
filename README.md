# 🍕 Pizza Sales Analysis (SQL Project)

## 📌 Project Overview
This project analyzes pizza sales data using SQL to extract meaningful business insights such as revenue trends, customer behavior, and product performance.

---

## 📊 Dataset Description
The dataset includes:
- Orders data
- Order details
- Pizza information
- Pizza categories and types

---

## 🎯 Business Questions Solved

1. Total number of orders
2. Total revenue generated
3. Top 5 most ordered pizzas
4. Highest priced pizza
5. Most common pizza size
6. Orders distribution by hour
7. Revenue by category

---

## 🛠️ Tools Used
- MySQL
- MySQL Workbench
- GitHub

---
## 🛠️ SQL Concepts Used
- JOIN
- GROUP BY
- ORDER BY
- Aggregations (SUM, COUNT)
- Window Functions (RANK, ROW_NUMBER)

## 📁 Files in this Repository
- `pizza_sales_analysis.sql` → SQL queries for analysis
  
## 📊 Sample Query

```sql
SELECT pt.name, SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 5;
---
## 💡 Key Insights
- Classic category generates highest revenue
- Evening hours have peak orders
- Large pizzas are most preferred
- Top products contribute major share of revenue

---

## 🚀 How to Use
1. Import dataset into MySQL
2. Run SQL queries from the `.sql` file
3. Analyze results

---

## 🔗 Author
Rajshree
