drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);


-- DATA EXPLORATION

-- Count of rows
SELECT COUNT(*) FROM zepto;


-- Reading some data 
SELECT * FROM zepto limit 10;


-- Checking null values
Select * from zepto where
name is null
or 
category is null
or
mrp is null
or
discountpercent is null
or
availablequantity is null
or
discountedsellingprice is null
or
weightingms is null
or 
outofstock is null
or
quantity is null;



-- Different product categories
SELECT DISTINCT category FROM zepto
ORDER BY category;



-- Products instock vs outofstock
SELECT outofstock, COUNT(sku_id) FROM zepto GROUP BY outofstock;


-- Product names present multiple times
SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;




-- DATA CLEANING

-- Products with price = 0
SELECT * FROM zepto WHERE
mrp = 0 or discountedsellingprice = 0;

DELETE FROM zepto WHERE mrp = 0



-- convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0

SELECT mrp, discountedsellingprice from zepto;









-- BUSINESS INSIGHT QUERIES

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountpercent 
FROM zepto
ORDER BY discountpercent DESC 
LIMIT 10

-- Q2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp, outofstock
FROM zepto
WHERE outofstock = TRUE AND mrp>300
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT category, ROUND(SUM(discountedsellingprice * availablequantity),1) as total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue desc;


-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp , discountpercent 
FROM zepto
WHERE mrp > 500 and discountpercent < 10
ORDER BY mrp desc;



-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category, ROUND(AVG(discountpercent),2) as average_discount_percentage
FROM zepto
GROUP BY category
ORDER BY average_discount_percentage DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightingms, discountedsellingprice,
ROUND((discountedsellingprice/weightingms),2) as price_per_gram
FROM zepto
WHERE weightingms >= 100 
ORDER BY price_per_gram;



-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT 
    name, 
    weightingms, 
    CASE 
        WHEN weightingms >= 0 AND weightingms < 1000 THEN 'low' 
        WHEN weightingms >= 1000 AND weightingms <= 5000 THEN 'Medium' 
        ELSE 'Bulk' 
    END AS weight_category 
FROM zepto;



-- Q8.What is the Total Inventory Weight Per Category
SELECT category,
SUM(weightingms * availablequantity) AS total_weight
from zepto
GROUP BY category
ORDER BY total_weight;



-- The "Top 5 Most Discounted" Items
SELECT name, category, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 5;


-- The "Stock Value" by Category (SAME AS Q3)
SELECT 
    category, 
    SUM(availableQuantity * discountedSellingPrice) AS total_stock_value
FROM zepto
GROUP BY category
ORDER BY total_stock_value DESC;


-- The "Ghost Inventory" Check
SELECT name, availableQuantity, outOfStock
FROM zepto
WHERE outofstock = TRUE AND availableQuantity > 0;



-- Adding weight_category to my SQL Table
-- Step 1: Add the empty column
ALTER TABLE zepto ADD COLUMN weight_category VARCHAR(20);

-- Step 2: Applying Logic
UPDATE zepto
SET weight_category = CASE 
        WHEN weightingms >= 0 AND weightingms < 1000 THEN 'Low' 
        WHEN weightingms >= 1000 AND weightingms <= 5000 THEN 'Medium' 
        ELSE 'Bulk' 
    END;

-- Verify the change
SELECT name, weightingms, weight_category FROM zepto LIMIT 10;


SELECT * FROM zepto limit 10;

