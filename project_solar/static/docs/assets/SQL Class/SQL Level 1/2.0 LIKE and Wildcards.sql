-- Text Filters and Logical Operators

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Filter with wildcard: 
--    SELECT name, user_city FROM users
--    WHERE user_city LIKE '%port%';


-- 2a. Case sensitivity in PostgreSQL:
--     LIKE is case sensitive
--     ILIKE is case insensitive
--     SELECT name, user_city FROM users
--     WHERE user_city ILIKE '%port%';


-- 2b. Case sensitivity in SQL Server:
--     SQL Server is case insensitive by default.
--     Case sensitivity is defined by the column, not the SQL statement.

--     Check server case sensitivity:
--     SELECT SERVERPROPERTY('COLLATION');

--     Check database case sensitivity:
--     SELECT DATABASEPROPERTYEX('noble_desktop', 'Collation') SQLCollation;

--     Check a table's case sensitivity for all columns:
--     SELECT table_name, column_name, collation_name
--     FROM INFORMATION_SCHEMA.COLUMNS
--     WHERE table_name = 'users';

--     SQL Server case sensitive query:
--     SELECT name, user_city FROM users
--     WHERE user_city LIKE '%port%' COLLATE SQL_Latin1_General_CP1_CS_AS;


-- 3. Filter using AND:
--    In PostgreSQL:
--    SELECT * FROM products
--    WHERE title ILIKE '%paper%' AND price > 30;

--    In SQL Server:
--    SELECT * FROM products
--    WHERE title LIKE '%paper%' AND price > 30;


-- 4. Filter using OR:
--    SELECT * FROM orders
--    WHERE ship_state = 'FL' OR ship_zipcode = '17408';


-- 5. Filter using NOT: 
--    SELECT * FROM products
--    WHERE NOT tags = 'emerald';


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Find all the users with a gmail email address.


-- 2. Find all the orders shipped to Florida or Texas.
--    Bonus: Order the results by the state.


-- 3. Find the 5 most recent orders shipped to New York.


-- 4. Select all the products that include the word 'plate' and cost more than $20.


-- 5. Find all the products that do NOT contain 'rubber' in the title.


-- 6. Find all the products that are tagged 'grey' or 'gray'
--    (notice the different spellings: one is 'e' and other 'a')


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. Find the most expensive items from line_items which status is 'returned'


-- 2. You can perform math in ORDER BY.
--    ORDER BY price multiplied by quantity to find the most expensive overall returns.

