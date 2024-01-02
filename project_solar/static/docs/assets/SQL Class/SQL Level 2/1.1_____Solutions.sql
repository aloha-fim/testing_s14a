-- Aggregate Functions and ROUND

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Find the total number of orders.
SELECT COUNT(*) FROM orders;


-- 2. Find the average product price.
SELECT AVG(price) FROM products;

-- Round to 2 decimal places
SELECT ROUND( AVG(price), 2 ) FROM products;

-- SQL Server: round to 2 decimal places without trailing zeros
SELECT CAST( AVG(price) AS DECIMAL(5,2) ) FROM products;


-- 3. Find the maximum product price that's NOT a lamp.
-- PostgreSQL:
SELECT MAX(price) FROM products
WHERE NOT title ILIKE '%lamp%';

-- SQL Server:
SELECT MAX(price) FROM products
WHERE NOT title LIKE '%lamp%';


-- 4. Find the number of users with a gmail email address.
SELECT COUNT(*) FROM users
WHERE email LIKE '%gmail.com';


-- 5. Using the line_items table, find the total dollar value 
--    of all items with status 'returned'.
SELECT SUM(price * quantity) FROM line_items
WHERE status = 'returned';


-- 6. Find the average price of all products containing the word 'hat' in their title.
-- PostgreSQL:
SELECT AVG(price) FROM products
WHERE title ILIKE '%hat%';

-- SQL Server:
SELECT CAST( AVG(price) AS DECIMAL(5,2) ) FROM products
WHERE title LIKE '%hat%';


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. You can may use multiple aggregation functions in one SELECT.
--    Using only one query, find the MIN(), MAX(), and AVG() 
--    of the prices in the product table.
SELECT MIN(price), MAX(price), AVG(price)
FROM products;

--    With nice column names (column aliases)
SELECT MIN(price) AS min_price,
MAX(price) AS max_price,
AVG(price) AS avg_price
FROM products;


-- 2. In one query, find the difference between the 
--    price of the most expensive and least expensive product.
SELECT MAX(price) - MIN(price)
FROM products;
