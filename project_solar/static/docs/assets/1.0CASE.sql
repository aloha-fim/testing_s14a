-- Conditionals

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Conditional (If you do not have an else, SQL will use null):
SELECT title,
   CASE  
      WHEN (price < 50) THEN 'cheap'
      WHEN (price > 50) THEN 'expensive'
      ELSE 'okay'
   END
FROM products;

-- 2. Conditional with a column alias:
SELECT title,
   CASE
      WHEN (price < 20) THEN 'cheap'
      WHEN (price < 50) THEN 'moderate'
      ELSE 'expensive'
   END AS pricing -- gives the column an alias named pricing
FROM products;



-- 3. Conditional with ORDER BY:
SELECT title,
   CASE
      WHEN (price < 20) THEN 'cheap'
      WHEN (price < 50) THEN 'moderate'
      ELSE 'expensive'
   END AS pricing
FROM products
ORDER BY pricing;

-- 4. Conditional with GROUP BY:
--    PostgreSQL:
SELECT -- remove title so we can count the groups
   CASE
      WHEN (price < 20) THEN 'cheap'
      WHEN (price < 50) THEN 'moderate'
      ELSE 'expensive'
   END AS pricing,
   COUNT(*)
FROM products
GROUP BY pricing;

--    SQL Server:
--    Unlike in PostgreSQL, you can't use an alias in the GROUP BY
--    So one option is to repeat the CASE
SELECT -- remove title so we can count the groups
   CASE
      WHEN (price < 20) THEN 'cheap'
      WHEN (price < 50) THEN 'moderate'
      ELSE 'expensive'
   END AS pricing,
   COUNT(*)
FROM products
GROUP BY
   CASE
      WHEN (price < 20) THEN 'cheap'
      WHEN (price < 50) THEN 'moderate'
      ELSE 'expensive'
   END
;


--   SQL Server Alternate Method (also works in PostgreSQL, but it's not the easiest way)
--   A Common Table Expression (CTE) is a temporary named result (like a temporary table), 
--   which we can create using the WITH clause.
--   Step 1: Create the table and join it to the products table
WITH
   cte_pricing (pricing, product_id) AS (
      SELECT
         CASE
            WHEN (price < 20) THEN 'cheap'
            WHEN (price < 50) THEN 'moderate'
            ELSE 'expensive'
         END,
         product_id
      FROM products
   )
SELECT *
FROM products p JOIN cte_pricing cp ON p.product_id = cp.product_id;

--   Step 2: Add the aggregate function (COUNT) and GROUP BY
WITH
   cte_pricing (pricing, product_id) AS (
      SELECT
         CASE
            WHEN (price < 20) THEN 'cheap'
            WHEN (price < 50) THEN 'moderate'
            ELSE 'expensive'
         END,
         product_id
      FROM products
   )
SELECT pricing, COUNT(*) AS count
FROM products p JOIN cte_pricing cp ON p.product_id = cp.product_id
GROUP BY pricing;



-- 4. SQL Server Only: IIF (Inline IF)
--    IIF is like a simplified CASE with only 2 possible outcomes
SELECT title,
   IIF( price < 40, 'cheap', 'expensive')  AS pricing
FROM products;



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Write a conditional that will categorize each order as
--    'West Coast' (if it was shipped to CA, OR, or WA) or 'Other'


-- 2. Modify the last query with a GROUP BY statement, to find
--    the number of orders shipped to West Coast states vs Others.


-- 3. Write a conditional to divide users into 3 groups, based on their created_at: 
--    early for accounts created in 2019 (the entire year) or prior
--    middle for accounts created in 2020 (the entire year)
--    late for accounts created in 2021 or later
--    Reminder: If you do not specify hours for a datetime column, the hours default to 00:00:00
--    So be sure to cast the datetime as a date to go all the way through the end of the day.


-- 4. We want to count the number of orders made by each group in the query above.
--    The users table doesn't have order info, so the first step is to 
--    modify the query above and join in the orders table.
--    You will not see the newly joined data because we're only showing the CASE column,
--    but you'll need it the step below when we group the data.
--    NOTE: Because created_at exists in both tables, you'll need to
--    prefix the table name or alias (example: users.created_at)


-- 5. Modify the query above, adding a GROUP BY to find which 
--    group of users made more orders: early, middle, or late.


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. Get the number of orders on weekdays or weekends (per state they were shipped to).
--    Reminder for PostgreSQL: The day of week is numbered Sunday as 0, Saturday as 6.
--    Reminder for SQL Server: The day of week is numbered Sunday as 1, Saturday as 7.


