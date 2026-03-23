-- =========================================
-- SQL PROJECT: Pizza Sales Analysis
-- =========================================

-- =========================================
-- BASIC METRICS
-- =========================================

-- 1. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- 2. Total Revenue
SELECT SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;

-- =========================================
-- PRODUCT PERFORMANCE
-- =========================================

-- 3. Top 5 Most Ordered Pizzas
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 4. Top 5 Revenue Generating Pizzas
SELECT pt.name, SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 5;

-- =========================================
-- CATEGORY ANALYSIS
-- =========================================

-- 5. Revenue by Category
SELECT pt.category, 
       SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- 6. Percentage Contribution by Category
SELECT pt.category,
       SUM(od.quantity * p.price) AS revenue,
       ROUND(100 * SUM(od.quantity * p.price) / 
       SUM(SUM(od.quantity * p.price)) OVER(), 2) AS contribution_percent
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- =========================================
-- SIZE ANALYSIS
-- =========================================

-- 7. Most Ordered Pizza Size
SELECT p.size, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC;

-- =========================================
-- TIME ANALYSIS
-- =========================================

-- 8. Orders by Hour
SELECT HOUR(order_time) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- 9. Revenue by Hour
SELECT HOUR(o.order_time) AS order_hour,
       SUM(od.quantity * p.price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY order_hour
ORDER BY order_hour;

-- =========================================
-- ADVANCED ANALYSIS
-- =========================================

-- 10. Rank Pizzas by Revenue
SELECT *,
RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM (
    SELECT pt.name,
           SUM(od.quantity * p.price) AS revenue
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.name
) ranked;

-- 11. Top 2 Pizzas in Each Category
SELECT *
FROM (
    SELECT pt.category,
           pt.name,
           SUM(od.quantity * p.price) AS revenue,
           ROW_NUMBER() OVER (
               PARTITION BY pt.category 
               ORDER BY SUM(od.quantity * p.price) DESC
           ) AS rank_in_category
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) ranked
WHERE rank_in_category <= 2;
