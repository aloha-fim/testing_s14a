-- SELECT Statements

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Write a SQL query to view the entire 'users' table.
SELECT * FROM users;


-- 2. View the first 5 rows of the 'users' table. 
-- PostgreSQL:
SELECT * FROM users LIMIT 5;

-- SQL Server:
SELECT TOP(5) * FROM users;


-- 3. View the 'users' table, ordered by when the users were created (from newest to oldest).
SELECT * FROM users ORDER BY created_at DESC;


-- 4. View the entire 'orders' table.
SELECT * FROM orders;


-- 5. View the name and state columns of the 'orders' table.
SELECT ship_name, ship_state FROM orders;


-- 6. View the 10 most recent orders.
-- PostgreSQL:
SELECT * FROM orders ORDER BY created_at DESC LIMIT 10;

-- SQL Server:
SELECT TOP(10) * FROM orders ORDER BY created_at DESC;


-- 7. Use DISTINCT to see which states people (users) are from (not where the orders were shipped).
SELECT DISTINCT user_state FROM users;


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. You can use DISTINCT on multiple columns.
--    Use DISTINCT on the orders table to see which states each user has shipped orders to.
SELECT DISTINCT user_id, ship_state FROM orders;


-- 2. SQL Server orders the results automatically, but Postgres does not.
--    Postgres Only: Modify the query above to ORDER BY user_id and then ship state.
SELECT DISTINCT user_id, ship_state FROM orders ORDER BY user_id, ship_state;
