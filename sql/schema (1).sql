-- Drop existing tables if they exist
DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS delivery_partners;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS promotions;
DROP TABLE IF EXISTS traffic;
DROP TABLE IF EXISTS weather;
DROP TABLE IF EXISTS customer_feedback;

-- 1. Cities Table
CREATE TABLE cities (
    city_id INTEGER PRIMARY KEY,
    city_name TEXT,
    state TEXT
);

-- 2. Customers Table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    email TEXT,
    phone TEXT,
    city_id INTEGER,
    signup_date DATE,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- 3. Restaurants Table
CREATE TABLE restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    restaurant_name TEXT,
    cuisine_type TEXT,
    city_id INTEGER,
    rating REAL,
    cost_for_two INTEGER,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- 4. Delivery Partners Table
CREATE TABLE delivery_partners (
    partner_id INTEGER PRIMARY KEY,
    partner_name TEXT,
    vehicle_type TEXT,
    rating REAL,
    city_id INTEGER,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- 5. Menu Table
CREATE TABLE menu (
    item_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER,
    item_name TEXT,
    category TEXT,
    price REAL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- 6. Orders Table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    restaurant_id INTEGER,
    partner_id INTEGER,
    order_date TIMESTAMP,
    order_status TEXT,
    delivery_time_mins INTEGER,
    order_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (partner_id) REFERENCES delivery_partners(partner_id)
);

-- 7. Order Items Table
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    item_id INTEGER,
    quantity INTEGER,
    item_price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu(item_id)
);

-- 8. Payments Table
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    payment_mode TEXT,
    payment_status TEXT,
    amount REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 9. Promotions Table
CREATE TABLE promotions (
    promo_id INTEGER PRIMARY KEY,
    promo_code TEXT,
    discount_percentage REAL,
    max_discount_amount REAL,
    valid_from DATE,
    valid_to DATE
);

-- 10. Traffic Table
CREATE TABLE traffic (
    traffic_id INTEGER PRIMARY KEY,
    city_id INTEGER,
    timestamp TIMESTAMP,
    traffic_condition TEXT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- 11. Weather Table
CREATE TABLE weather (
    weather_id INTEGER PRIMARY KEY,
    city_id INTEGER,
    timestamp TIMESTAMP,
    weather_condition TEXT,
    temperature REAL,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- 12. Customer Feedback Table
CREATE TABLE customer_feedback (
    feedback_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    customer_id INTEGER,
    rating INTEGER,
    review_text TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);