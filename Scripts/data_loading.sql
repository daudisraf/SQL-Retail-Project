-- Use the database
USE retail_db;

-- 1. Loading Customers
LOAD DATA INFILE '/absolute/path/to/your/data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2. Loading Stores
LOAD DATA INFILE '/absolute/path/to/your/data/stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. Loading Products
LOAD DATA INFILE '/absolute/path/to/your/data/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 4. Loading Exchange Rates
LOAD DATA INFILE '/absolute/path/to/your/data/exchange_rates.csv'
INTO TABLE exchange_rates
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 5. Loading Sales (The Fact Table)
LOAD DATA INFILE '/absolute/path/to/your/data/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;