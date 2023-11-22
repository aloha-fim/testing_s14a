-- Aggregate Functions and ROUND

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Using MAX and MIN:
--    SELECT MAX(price) FROM products;
--    SELECT MIN(price) FROM products;


-- 2. Using COUNT:
--    SELECT COUNT(*) FROM users;


-- 3. Using SUM:
--    SELECT SUM(price) FROM line_items;


-- 4. Using AVG:
--    SELECT AVG(price) FROM line_items;


-- 5. Using an alias to name the column:
--    SELECT AVG(price) AS "average price"
--    FROM line_items;


-- 6. Rounding to a whole number:
--    PostgreSQL:
--    SELECT ROUND( AVG(price) ) FROM line_items;

--    SQL Server: This rounds to a whole number, but you get trailing zeros:
--    SELECT ROUND( AVG(price), 0 ) FROM line_items;

--    SQL Server: This converts to an integer (whole number) with no trailing zeros:
--    SELECT CAST( AVG(price) AS INT ) FROM line_items;
--    NOTE: The above query also works in PostgreSQL.


-- 7. Rounding to 2 decimal places:
--    PostgreSQL:
--    SELECT ROUND( AVG(price), 2 ) FROM line_items;

--    SQL Server: This rounds to 2 decimal places, but you get trailing zeros:
--    SELECT ROUND( AVG(price), 2 ) FROM line_items;

--    SQL Server: This rounds 2 decimal places, with no trailing zeros:
--    SELECT CAST( AVG(price) AS DECIMAL(5,2) ) FROM line_items;
--    NOTE: DECIMAL(5,2) means the number can be up to 5 total digits 
--    (including left and right side of decimal point),
--    with 2 digits to the right of the decimal place.



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Find the total number of orders.


-- 2. Find the average product price.


-- 3. Find the maximum product price that's NOT a lamp.


-- 4. Find the number of users with a gmail email address.


-- 5. Using the line_items table, find the total dollar value 
--    of all items with status 'returned'.


-- 6. Find the average price of all products containing the word 'hat' in their title.


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. You can may use multiple aggregation functions in one SELECT.
--    Using only one query, find the MIN(), MAX(), and AVG() 
--    of the prices in the product table.


-- 2. In one query, find the difference between the 
--    price of the most expensive and least expensive product.

