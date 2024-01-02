-- SELECT Statements

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. View entire table:
--    SELECT * FROM products;


-- 2. Only 2 columns from table:
--    SELECT title, price FROM products;


--    Double quotes "" in PostgreSQL or square brackets [] in SQL Server are used
--    if the column name contains a reserved keyword or contains special characters
--    such as a space. Our database does not have any column names that will require them.
--    NOTE: In PostgreSQL, using the quotes makes the column name case sensitive.

--    In PostgreSQL:
--    SELECT "title", "price" FROM products;


--    In SQL Server:
--    SELECT [title], [price] FROM products;



-- 3. Only 10 rows from table:
--    In PostgreSQL:
--    SELECT * FROM products LIMIT 10;


--    In SQL Server:
--    SELECT TOP(10) * FROM products;
--    NOTE: TOP can also be written in an older syntax without parenthesis as TOP 10
--    but the parenthesis are the newer (and now preferred) syntax.



-- 4. Order by a column name or number:
--    SELECT * FROM products ORDER BY price;
--    SELECT title, price FROM products ORDER BY 2;


-- 5. Order by a column in descending order (large–small, Z–A, new–old):
--    SELECT * FROM products ORDER BY price DESC;



-- 6. Show only the tags for products:
--    SELECT tags FROM products;



-- 7. Show distinct tags (do not show duplicates):
--    SELECT DISTINCT tags FROM products;



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Write a SQL query to view the entire 'users' table.


-- 2. View the first 5 rows of the 'users' table. 


-- 3. View the 'users' table, ordered by when the users were created (from newest to oldest).


-- 4. View the entire 'orders' table.


-- 5. View the name and state columns of the 'orders' table.


-- 6. View the 10 most recent orders.


-- 7. Use DISTINCT to see which states people (users) are from (not where the orders were shipped).


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. You can use DISTINCT on multiple columns.
--    Use DISTINCT on the orders table to see which states each user has shipped orders to.


-- 2. SQL Server orders the results automatically, but PostgreSQL does not.
--    PostgreSQL Only: Modify the query above to ORDER BY user_id and then ship state.

