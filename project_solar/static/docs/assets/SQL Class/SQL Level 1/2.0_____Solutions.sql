-- Text Filters and Logical Operators

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Find all the users with a gmail email address.
SELECT * FROM users
WHERE email LIKE '%gmail.com';


-- 2. Find all the orders shipped to Florida or Texas.
--    Below are 2 solutions that both work:
SELECT * FROM orders
WHERE ship_state = 'FL' OR ship_state = 'TX';
-- or
SELECT * FROM orders
WHERE ship_state IN ('FL', 'TX');

--    Bonus: Order the results by the state.
SELECT * FROM orders
WHERE ship_state IN ('FL', 'TX')
ORDER BY ship_state;



-- 3. Find the 5 most recent orders shipped to New York.
-- PostgreSQL:
SELECT * FROM orders
WHERE ship_state = 'NY'
ORDER BY created_at DESC LIMIT 5;

-- SQL Server:
SELECT TOP(5) * FROM orders
WHERE ship_state = 'NY'
ORDER BY created_at DESC;



-- 4. Select all the products that include the word 'plate' and cost more than $20.
-- PostgreSQL:
SELECT * FROM products
WHERE title ILIKE '%plate%' AND price > 20;

-- SQL Server:
SELECT * FROM products
WHERE title LIKE '%plate%' AND price > 20;



-- 5. Find all the products that do NOT contain 'rubber' in the title.
-- PostgreSQL:
SELECT * FROM products
WHERE NOT title ILIKE '%rubber%';

-- SQL Server:
SELECT * FROM products
WHERE NOT title LIKE '%rubber%';



-- 6. Find all the products that are tagged 'grey' or 'gray'
--    (notice the different spellings: one is 'e' and other 'a')
-- PostgreSQL:
SELECT * FROM products
WHERE tags ILIKE '%grey%' OR tags ILIKE '%gray%';
-- OR
SELECT * FROM products
WHERE tags ILIKE '%gr_y%';

-- SQL Server:
SELECT * FROM products
WHERE tags LIKE '%grey%' OR tags LIKE '%gray%';
-- OR
SELECT * FROM products
WHERE tags LIKE '%gr_y%';



----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. Find the most expensive items from line_items which status is 'returned'
SELECT * FROM line_items
WHERE status = 'returned'
ORDER BY price DESC;


-- 2. You can perform math in ORDER BY.
--    ORDER BY price multiplied by quantity to find the most expensive overall returns.
SELECT * FROM line_items
WHERE status = 'returned'
ORDER BY price * quantity DESC;

