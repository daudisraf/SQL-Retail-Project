USE retail_db;

-- 1. Total Sales Revenue by Customer
SELECT 
    c.Name AS Customer_Name,
    ROUND(SUM(s.Quantity * CAST(REPLACE(REPLACE(p.`Unit Price USD`, '$', ''), ' ', '') AS DECIMAL(10,2))), 2) AS Total_Revenue
FROM sales s
JOIN customers c ON s.CustomerKey = c.CustomerKey
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY c.CustomerKey, c.Name
ORDER BY Total_Revenue DESC;

-- 2. Sales Performance by Store
SELECT 
    st.StoreKey,
    st.Country,
    st.State,
    ROUND(SUM(s.Quantity * CAST(REPLACE(REPLACE(p.`Unit Price USD`, '$', ''), ' ', '') AS DECIMAL(10,2))), 2) AS Total_Sales
FROM sales s
JOIN stores st ON s.StoreKey = st.StoreKey
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY st.StoreKey, st.Country, st.State
ORDER BY Total_Sales DESC;

-- 3. Top Selling Products
SELECT 
    p.`Product Name`,
    p.Category,
    SUM(s.Quantity) AS Units_Sold
FROM sales s
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, p.`Product Name`, p.Category
ORDER BY Units_Sold DESC
LIMIT 10;

-- 4. Customer Demographics Breakdown
SELECT 
    Gender,
    Continent,
    COUNT(CustomerKey) AS Total_Customers
FROM customers
GROUP BY Gender, Continent;

-- 5. Sales Trends Over Time (Monthly)
SELECT 
    DATE_FORMAT(STR_TO_DATE(s.`Order Date`, '%m/%d/%Y'), '%Y-%m') AS Month,
    ROUND(SUM(s.Quantity * CAST(REPLACE(REPLACE(p.`Unit Price USD`, '$', ''), ' ', '') AS DECIMAL(10,2))), 2) AS Monthly_Revenue
FROM sales s
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY Month
ORDER BY Month;

-- 6. Average Order Value (AOV) by Store
SELECT 
    st.StoreKey,
    st.Country,
    ROUND(
        SUM(s.Quantity * CAST(REPLACE(REPLACE(p.`Unit Price USD`, '$', ''), ' ', '') AS DECIMAL(10,2))) 
        / COUNT(DISTINCT s.`Order Number`), 2
    ) AS Avg_Order_Value
FROM sales s
JOIN stores st ON s.StoreKey = st.StoreKey
JOIN products p ON s.ProductKey = p.ProductKey
GROUP BY st.StoreKey, st.Country
ORDER BY Avg_Order_Value DESC;

-- 7. Customer Purchase Frequency
SELECT 
    c.Name,
    COUNT(DISTINCT s.`Order Number`) AS Total_Orders
FROM sales s
JOIN customers c ON s.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey, c.Name
ORDER BY Total_Orders DESC;

-- 8. Yearly Sales Growth Rate
WITH Yearly_Sales AS (
    SELECT 
        YEAR(STR_TO_DATE(s.`Order Date`, '%m/%d/%Y')) AS Year,
        SUM(s.Quantity * CAST(REPLACE(REPLACE(p.`Unit Price USD`, '$', ''), ' ', '') AS DECIMAL(10,2))) AS Revenue
    FROM sales s
    JOIN products p ON s.ProductKey = p.ProductKey
    GROUP BY Year
)
SELECT 
    Year,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(LAG(Revenue) OVER (ORDER BY Year), 2) AS Prev_Year_Revenue,
    ROUND(((Revenue - LAG(Revenue) OVER (ORDER BY Year)) / LAG(Revenue) OVER (ORDER BY Year)) * 100, 2) AS Growth_Percentage
FROM Yearly_Sales;