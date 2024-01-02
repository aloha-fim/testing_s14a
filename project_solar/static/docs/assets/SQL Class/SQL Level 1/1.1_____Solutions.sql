-- Filtering Results: Numeric, WHERE, OR, and IN

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Find all rows from the orders table with user_id 30.
SELECT * FROM orders
WHERE user_id = 30;

-- 2. Select all columns from line_items where someone ordered a quantity of 3 or more.
SELECT * FROM line_items
WHERE quantity >= 3;

-- 3. Select the rows from line_items with a price less than $30.
SELECT * FROM line_items
WHERE price < 30;

-- 4. Select the rows from line_items with a price of $30 or more, ordered by most expensive first.
SELECT * FROM line_items
WHERE price >= 30
ORDER BY price DESC;

-- 5. Limit the results to just see the top 20 most expensive line_items.
-- PostgreSQL:
SELECT * FROM line_items
ORDER BY price DESC LIMIT 20;

-- SQL Server:
SELECT TOP(20) * FROM line_items
ORDER BY price DESC;

-- 6. Find the orders that were shipped to zipcode 10499 or 77719.
--    Keep in mind that zipcodes are stored as strings, not numbers!
SELECT * FROM orders
WHERE ship_zipcode IN ('10499', '77719');

-- 7. Modify the last query to see only the DISTINCT names of the people those orders were shipped to.
SELECT DISTINCT ship_name FROM orders
WHERE ship_zipcode IN ('10499', '77719');

----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. View the 3 most recent orders made by user_id 33.
-- PostgreSQL:
SELECT * FROM orders
WHERE user_id = 33
ORDER BY created_at LIMIT 3;

-- SQL Server:
SELECT TOP(3) * FROM orders
WHERE user_id = 33
ORDER BY created_at;


-- 2. Use DISTINCT to find out which states user_id 33 has shipped orders to.
SELECT DISTINCT ship_state FROM orders
WHERE user_id = 33;
