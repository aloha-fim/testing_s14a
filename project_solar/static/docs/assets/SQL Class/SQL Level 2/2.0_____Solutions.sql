-- GROUP BY

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. When was the most recent order made in each state?
SELECT ship_state, MAX(created_at) 
FROM orders
GROUP BY ship_state;

-- 2. Use the line_items table to find the total number of each product_id sold.
--    Make sure you exclude returned and canceled from your results.
SELECT product_id, SUM(quantity) AS total_sold
FROM line_items
WHERE status != 'returned' AND status != 'canceled'
GROUP BY product_id
ORDER BY total_sold DESC;

-- 3. Use the line_items table to see the total dollar amount of items in each status (returned, shipped, etc.)
SELECT status, SUM(price * quantity)
FROM line_items
GROUP BY status;

-- 4. In the products table, find how many products are under each set of tags.
SELECT tags, COUNT(*)
FROM products
GROUP BY tags;

-- 5. Modify the previous query to find how many products over $70 are under each set of tags.
SELECT tags, COUNT(*)
FROM products
WHERE price > 70
GROUP BY tags;

-- 6. Use the orders table to find out how many orders each user made.
SELECT user_id, COUNT(*)
FROM orders
GROUP BY user_id;

-- 7. What is the first order that was made in each state, in each zipcode?
--    Zipcodes do not repeat between states, but write your query as though they do
--    because it's nice to see the state for context.
SELECT ship_state, ship_zipcode, MIN(created_at)
FROM orders
GROUP BY ship_state, ship_zipcode
ORDER BY ship_state;



----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

/******************************************************/
-- PostgreSQL
/******************************************************/

-- 1. Use DATE_PART to extract which calendar month each user was created in.
SELECT DATE_PART('month', created_at) 
FROM users;

-- 2. Use DATE_PART and a GROUP BY statement to count how many users were created in each calendar month.
-- Basic: Just show numbers for month
SELECT DATE_PART('month', created_at), COUNT(*)
FROM users
GROUP BY date_part
ORDER BY date_part;

-- Advanced: Also show names of the months
SELECT
   DATE_PART('month', created_at) AS month_number,
   TO_CHAR(created_at, 'Month') AS month_name,
   COUNT(*)
FROM users
GROUP BY month_number, month_name
ORDER BY month_number;


-- 3. Use DATE_PART to find the number of users created during each day of the week.
-- Basic: Just show numbers for days
SELECT DATE_PART('dow', created_at), COUNT(*)
FROM users
GROUP BY date_part
ORDER BY date_part;

-- Advanced: Also show names of the days
SELECT
   DATE_PART('dow', created_at) AS day_number,
   TO_CHAR(created_at, 'Day') as day_name,
   COUNT(*)
FROM users
GROUP BY day_number, day_name
ORDER BY day_number;



/******************************************************/
-- SQL Server
/******************************************************/

-- 1. Use DATE_PART to extract which calendar month each user was created in.
SELECT DATEPART(month, created_at) 
FROM users;


-- 2. Use DATE_PART and a GROUP BY statement to count how many users were created in each calendar month.
-- Basic: Just show numbers for month
SELECT DATEPART(month, created_at), COUNT(*)
FROM users
GROUP BY DATEPART(month, created_at);

-- Advanced: Also show names of the months
SELECT
   DATEPART(month, created_at) AS month_number,
   DATENAME(month, created_at) AS month_name,
   COUNT(*)
FROM users
GROUP BY DATEPART(month, created_at), DATENAME(month, created_at)
ORDER BY month_number;


-- 3. Use DATE_PART to find the number of users created during each day of the week.
-- Basic: Just show numbers for days
SELECT DATEPART(dw, created_at), COUNT(*)
FROM users
GROUP BY DATEPART(dw, created_at);

-- Advanced: Also show names of the days
SELECT
   DATEPART(dw, created_at) AS day_number,
   DATENAME(dw, created_at) AS day_name,
   COUNT(*)
FROM users
GROUP BY DATEPART(dw, created_at), DATENAME(dw, created_at)
ORDER BY day_number;
