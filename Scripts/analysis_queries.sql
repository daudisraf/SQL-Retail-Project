USE retail_db;

-- 1. Total Sales Revenue by Customer
SELECT 
    c.name AS customer_name,
    SUM(s.quantity * p.unit_price_usd) AS total_revenue
FROM sales s
JOIN customers c ON s.customer_key = c.customer_key
JOIN products p ON s.product_key = p.product_key
GROUP BY c.customer_key, c.name
ORDER BY total_revenue DESC;

-- 2. Sales Performance by Store
SELECT 
    st.store_key,
    st.country,
    st.state,
    SUM(s.quantity * p.unit_price_usd) AS total_sales
FROM sales s
JOIN stores st ON s.store_key = st.store_key
JOIN products p ON s.product_key = p.product_key
GROUP BY st.store_key, st.country, st.state
ORDER BY total_sales DESC;

-- 3. Top Selling Products
SELECT 
    p.product_name,
    p.category,
    SUM(s.quantity) AS total_quantity_sold
FROM sales s
JOIN products p ON s.product_key = p.product_key
GROUP BY p.product_key, p.product_name, p.category
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 4. Customer Demographics Breakdown
SELECT 
    gender,
    continent,
    COUNT(customer_key) AS total_customers
FROM customers
GROUP BY gender, continent;

-- 5. Sales Trends Over Time (Monthly)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(s.quantity * p.unit_price_usd) AS monthly_revenue
FROM sales s
JOIN products p ON s.product_key = p.product_key
GROUP BY month
ORDER BY month;

-- 6. Average Order Value (AOV) by Store
SELECT 
    st.store_key,
    SUM(s.quantity * p.unit_price_usd) / COUNT(DISTINCT s.order_number) AS avg_order_value
FROM sales s
JOIN stores st ON s.store_key = st.store_key
JOIN products p ON s.product_key = p.product_key
GROUP BY st.store_key;

-- 7. Customer Purchase Frequency
SELECT 
    c.name,
    COUNT(DISTINCT s.order_number) AS total_orders
FROM sales s
JOIN customers c ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.name
ORDER BY total_orders DESC;

-- 8. Yearly Sales Growth Rate
WITH yearly_sales AS (
    SELECT 
        YEAR(order_date) AS year,
        SUM(s.quantity * p.unit_price_usd) AS revenue
    FROM sales s
    JOIN products p ON s.product_key = p.product_key
    GROUP BY year
)
SELECT 
    year,
    revenue,
    LAG(revenue) OVER (ORDER BY year) AS prev_year_revenue,
    (revenue - LAG(revenue) OVER (ORDER BY year)) / LAG(revenue) OVER (ORDER BY year) * 100 AS growth_rate
FROM yearly_sales;