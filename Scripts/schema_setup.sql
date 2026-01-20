-- Create the Database
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- 1. Create Customers Table
CREATE TABLE customers (
    customer_key INT PRIMARY KEY,
    gender VARCHAR(10),
    name VARCHAR(100),
    city VARCHAR(100),
    state_code VARCHAR(10),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100),
    continent VARCHAR(100),
    birthday DATE
);

-- 2. Create Stores Table
CREATE TABLE stores (
    store_key INT PRIMARY KEY,
    country VARCHAR(100),
    state VARCHAR(100),
    square_meters INT,
    open_date DATE
);

-- 3. Create Products Table
CREATE TABLE products (
    product_key INT PRIMARY KEY,
    product_name VARCHAR(255),
    brand VARCHAR(100),
    color VARCHAR(50),
    unit_cost_usd DECIMAL(10, 2),
    unit_price_usd DECIMAL(10, 2),
    subcategory_key INT,
    subcategory VARCHAR(100),
    category_key INT,
    category VARCHAR(100)
);

-- 4. Create Exchange Rates Table
CREATE TABLE exchange_rates (
    date DATE,
    currency VARCHAR(10),
    exchange DECIMAL(10, 4)
);

-- 5. Create Sales Table (Fact Table)
CREATE TABLE sales (
    order_number INT,
    line_item INT,
    order_date DATE,
    delivery_date DATE,
    customer_key INT,
    store_key INT,
    product_key INT,
    quantity INT,
    currency_code VARCHAR(10),
    -- Define Relationships
    FOREIGN KEY (customer_key) REFERENCES customers(customer_key),
    FOREIGN KEY (store_key) REFERENCES stores(store_key),
    FOREIGN KEY (product_key) REFERENCES products(product_key)
);