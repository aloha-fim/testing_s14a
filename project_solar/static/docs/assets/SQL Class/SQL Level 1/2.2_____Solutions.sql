--  Outer Joins and NULLS

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Join the products table to the line_items table.
--    Choose a join that will KEEP products even if they don't have any associated line_items.
SELECT * FROM products p
LEFT JOIN line_items li ON p.product_id = li.product_id;


-- 2. Were there any products with no orders? 
--    Query the joined table for rows with NULL quantity. 
SELECT * FROM products p
LEFT JOIN line_items li ON p.product_id = li.product_id
WHERE quantity IS NULL;


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. Let's find the names of people who ordered something in a quantity of 5 or greater: 

--    A. First, join the tables.
--       Which kind of join is appropriate and which tables are you joining?
SELECT * FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN line_items li ON o.order_id = li.order_id;

--    B. Second, only show people who ordered something in a quantity of 5 or greater.
--       In the results, only display the name, email, and quantity
--       with the highest quantity at the top (also put the names in alphabetical order).
SELECT u.name, u.email, li.quantity FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN line_items li ON o.order_id = li.order_id
WHERE li.quantity >= 5
ORDER BY li.quantity DESC, name;