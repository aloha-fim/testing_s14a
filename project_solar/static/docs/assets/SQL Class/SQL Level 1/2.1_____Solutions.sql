-- Inner Joins and Aliases

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- Let's find the name and email of people who ordered a total of $700 or more.
-- We'll walk you through building up the query over several steps.

-- 1. Select everything from the line_items table.
-- In the results, notice it contains the price and quantity, but not who ordered.
SELECT *
FROM line_items;


-- 2. Join the line_items table to the orders table (on the order_id column)
-- In the results, notice you can now see price, quantity, and user_id.

-- Without Aliases
SELECT *
FROM line_items
JOIN orders ON line_items.order_id = orders.order_id;

-- With Aliases
SELECT *
FROM line_items li
JOIN orders o ON li.order_id = o.order_id;


-- 3. We want to get the user's name, so continuing with the previous query,
-- also join in the users table (on the user_id column).
-- In the results, notice you can now see the price, quantity, and name of the user.
SELECT *
FROM line_items li
JOIN orders o ON li.order_id = o.order_id
JOIN users u ON u.user_id  = o.user_id;


-- 4. Continuing with the previous query, filter the results to show 
-- just the name and email of people who ordered a total of $700 or more.
-- Don't forget that involves math for quantity times price.
SELECT u.name, u.email
FROM line_items li
JOIN orders o ON li.order_id = o.order_id
JOIN users u ON u.user_id  = o.user_id
WHERE li.price * li.quantity >= 700;
