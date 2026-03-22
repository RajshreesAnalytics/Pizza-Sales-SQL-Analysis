-- =========================================
-- SQL PROJECT: Pizza Sales Analysis
-- =========================================

-- Objective:
-- Analyze pizza sales data to extract business insights

-- =========================================
-- BASIC METRICS
-- =========================================

-- 1. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- 2. Total Revenue
SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM order_details
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id;

-- =========================================
-- PRODUCT INSIGHTS
-- =========================================

-- 3. Top 5 Most Ordered Pizzas
SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 4. Highest Priced Pizza
SELECT pizza_types.name, pizzas.price
FROM pizzas
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- =========================================
-- SALES PATTERNS
-- =========================================

-- 5. Most Common Pizza Size
SELECT pizzas.size, COUNT(*) AS order_count
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- 6. Orders by Hour
SELECT HOUR(order_time) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- =========================================
-- ADVANCED ANALYSIS
-- =========================================

-- 7. Revenue by Category
SELECT pizza_types.category, 
       SUM(order_details.quantity * pizzas.price) AS revenue
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;
