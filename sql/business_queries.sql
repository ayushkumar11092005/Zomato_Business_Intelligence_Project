-- 1. Total revenue generated across all orders
SELECT SUM(order_amount) AS total_revenue FROM orders;

-- 2. Top 5 restaurants by total order volume
SELECT r.restaurant_name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY total_orders DESC
LIMIT 5;

-- 3. Monthly order trend
SELECT strftime('%Y-%m', order_date) AS order_month, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- 4. Average delivery time by city
SELECT c.city_name, AVG(o.delivery_time_mins) AS avg_delivery_time
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN cities c ON r.city_id = c.city_id
GROUP BY c.city_name;

-- 5. Customer retention / repeat customers
SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING order_count > 1;

-- 6. Most popular food items by quantity sold
SELECT m.item_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN menu m ON oi.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_sold DESC
LIMIT 5;

-- 7. Payment method distribution
SELECT payment_mode, COUNT(payment_id) AS usage_count
FROM payments
GROUP BY payment_mode;

-- 8. Average rating of delivery partners
SELECT partner_id, AVG(rating) AS avg_rating
FROM delivery_partners
GROUP BY partner_id
ORDER BY avg_rating DESC;

-- 9. Orders affected by bad weather conditions
SELECT w.weather_condition, COUNT(o.order_id) AS affected_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN weather w ON r.city_id = w.city_id
GROUP BY w.weather_condition;

-- 10. High traffic impact on delivery times
SELECT t.traffic_condition, AVG(o.delivery_time_mins) AS avg_delivery_time
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN traffic t ON r.city_id = t.city_id
GROUP BY t.traffic_condition;

-- 11. Average order value (AOV) by cuisine type
SELECT r.cuisine_type, AVG(o.order_amount) AS avg_order_value
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine_type;

-- 12. City-wise total revenue
SELECT c.city_name, SUM(o.order_amount) AS total_revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN cities c ON r.city_id = c.city_id
GROUP BY c.city_name;

-- 13. Cancelled orders percentage
SELECT 
    (SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS cancellation_rate
FROM orders;

-- 14. Top 5 highest spending customers
SELECT c.customer_name, SUM(o.order_amount) as total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- 15. Average feedback rating per restaurant
SELECT r.restaurant_name, AVG(f.rating) AS avg_feedback_rating
FROM customer_feedback f
JOIN orders o ON f.order_id = o.order_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name;

-- 16. Orders distribution by hours of the day
SELECT strftime('%H', order_date) AS order_hour, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- 17. Delivery partners performance based on delivery time
SELECT dp.partner_name, AVG(o.delivery_time_mins) AS avg_time
FROM orders o
JOIN delivery_partners dp ON o.partner_id = dp.partner_id
GROUP BY dp.partner_name
ORDER BY avg_time ASC;

-- 18. Restaurant count per city
SELECT c.city_name, COUNT(r.restaurant_id) AS restaurant_count
FROM restaurants r
JOIN cities c ON r.city_id = c.city_id
GROUP BY c.city_name;

-- 19. Top revenue-generating menu items
SELECT m.item_name, SUM(oi.quantity * oi.item_price) AS total_item_revenue
FROM order_items oi
JOIN menu m ON oi.item_id = m.item_id
GROUP BY m.item_name
ORDER BY total_item_revenue DESC
LIMIT 5;

-- 20. Customer feedback rating distribution
SELECT rating, COUNT(feedback_id) AS rating_count
FROM customer_feedback
GROUP BY rating
ORDER BY rating DESC;

-- 21. Peak order days of the week
SELECT strftime('%w', order_date) AS day_of_week, COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_of_week
ORDER BY total_orders DESC;