--  Subqueries

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Single-value subquery:
--    SELECT * FROM line_items 
--    WHERE price = (SELECT MAX(price) FROM products);


-- 2. Multiple-value subquery:
--    SELECT * FROM orders 
--    WHERE user_id IN (
--       SELECT user_id FROM users
--       WHERE email LIKE '%@gmail.com'
--    );


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Select the products that cost more than average (use a subquery).


-- 2. Find all the line_items that represent orders for the lowest-priced product.


-- 3. Find the oldest order made by a user with a yahoo email address.


-- 4. List the titles of the products that were ever returned in quantities greater than 4.

