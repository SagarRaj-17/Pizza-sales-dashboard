
SELECT * FROM pizza_sales;

-- Total revenue from sale of pizza.
SELECT CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_revenue FROM pizza_sales;

-- Average order value.
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) AS Avg_order_value FROM pizza_sales;

-- Total number of pizza sold.
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- Total number of order placed.
SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales;

-- Average pizza per Order
SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id),2) AS Avg_pizza_per_order FROM pizza_sales;
-- OR
SELECT  CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
 CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2) ) AS Avg_pizza_per_order FROM pizza_sales;

-- Daily Trend  
SELECT 
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date) , DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);

-- Hourly Trend
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hour ;

-- Sales % by Category
SELECT pizza_category, ROUND(SUM(total_price),2) AS total_sales,
 ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales),2) AS Sales_per_category 
FROM pizza_sales 
GROUP BY pizza_category;

-- Sales by pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Sale_by_Size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Sale_by_Size DESC;

-- Total pizza sold by Category
SELECT pizza_category, SUM(quantity) AS total_quantity_sold FROM pizza_sales
GROUP BY pizza_category;

-- TOP 5 best Seller 
SELECT pizza_name, SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold DESC
LIMIT 5 ;

-- Worst 5 Seller
SELECT pizza_name, SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_sold 
LIMIT 5 ;
