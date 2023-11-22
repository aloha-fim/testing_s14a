-- Filtering Results: Numeric, WHERE, OR, and IN

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Filter by exact value:
--    SELECT * FROM products
--    WHERE price = 31.98;


-- 2. Filter using less-than:
--    SELECT * FROM products
--    WHERE price < 31.98;


-- 3. Filter using greater-than or equals: 
--    SELECT * FROM products
--    WHERE price >= 31.98;


-- 4. Filter using multiple conditions (using OR): 
--    SELECT * FROM products
--    WHERE price = 31.98
--    OR price= 28.87;


-- 5. Filter using set of values (using IN): 
--    Does the same thing as the previous OR statement, but with less code.
--    SELECT * FROM products
--    WHERE price IN (31.98, 28.87);


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Find all rows from the orders table with user_id 30.


-- 2. Select all columns from line_items where someone ordered a quantity of 3 or more.


-- 3. Select the rows from line_items with a price less than $30.


-- 4. Select the rows from line_items with a price of $30 or more, ordered by most expensive first.


-- 5. Limit the results to just see the top 20 most expensive line_items.


-- 6. Find the orders that were shipped to zipcode 10499 or 77719
--    Keep in mind that zipcodes are stored as strings, not numbers!


-- 7. Modify the last query to see only the DISTINCT names of the people those orders were shipped to.


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. View the 3 most recent orders made by user_id 33.


-- 2. Use DISTINCT to find out which states user_id 33 has shipped orders to.

