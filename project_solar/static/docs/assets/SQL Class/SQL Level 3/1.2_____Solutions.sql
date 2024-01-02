-- Subqueries

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Select the products that cost more than average (use a subquery).
SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);


-- 2. Find all the line_items that represent orders for the lowest-priced product.
SELECT * FROM line_items 
WHERE price = (SELECT MIN(price) FROM products);


-- 3. Find the oldest order made by a user with a yahoo email address.
/******************************************************/
-- PostgreSQL
/******************************************************/
SELECT * FROM orders 
WHERE user_id IN (
   SELECT user_id FROM users
   WHERE email ILIKE '%@yahoo.com'
)
ORDER BY created_at
LIMIT 1;

-- If you want include the user's email, you'd have to do a join:
SELECT *
FROM orders AS o
JOIN users AS u ON o.user_id = u.user_id 
WHERE u.email ILIKE '%yahoo.com'
ORDER BY o.created_at
LIMIT 1;


/******************************************************/
-- SQL Server
/******************************************************/
SELECT TOP(1) * FROM orders 
WHERE user_id IN (
   SELECT user_id FROM users
   WHERE email LIKE '%@yahoo.com'
)
ORDER BY created_at;

-- If you want include the user's email, you'd have to do a join:
SELECT TOP(1) *
FROM orders AS o
JOIN users AS u ON o.user_id = u.user_id 
WHERE u.email LIKE '%yahoo.com'
ORDER BY o.created_at;



-- 4. List the titles of the products that were ever returned in quantities greater than 4.
SELECT title FROM products 
WHERE product_id IN (
   SELECT DISTINCT product_id FROM line_items
   WHERE quantity > 4 AND status = 'returned'
);

