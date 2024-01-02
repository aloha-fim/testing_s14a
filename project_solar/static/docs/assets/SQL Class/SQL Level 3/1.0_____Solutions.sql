-- Conditionals

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Write a conditional that will categorize each order as
--    'West Coast' (if it was shipped to CA, OR, or WA) or 'Other'

-- Works in both PostgreSQL and SQL Server:
SELECT ship_state,
   CASE 
      WHEN (ship_state IN ('CA', 'OR', 'WA')) THEN 'West Coast'
      ELSE 'Other'
   END
FROM orders;

-- Works in SQL Server Only:
SELECT ship_state,
   IIF(ship_state IN ('CA', 'OR', 'WA'), 'West Coast', 'Other')
FROM orders;




-- 2. Modify the last query with a GROUP BY statement, to find
--    the number of orders shipped to West Coast states vs Others.

-- Works in PostgreSQL Only: We can use an alias to make it easier to read (and much cleaner code)
SELECT
   CASE 
      WHEN (ship_state IN ('CA', 'OR', 'WA')) THEN 'West Coast'
      ELSE 'Other'
   END AS coast,
   COUNT(*)
FROM orders
GROUP BY coast;

-- Works in both PostgreSQL and SQL Server:
SELECT
   CASE 
      WHEN (ship_state IN ('CA', 'OR', 'WA')) THEN 'West Coast'
      ELSE 'Other'
   END,
   COUNT(*)
FROM orders
GROUP BY
   CASE 
      WHEN (ship_state IN ('CA', 'OR', 'WA')) THEN 'West Coast'
      ELSE 'Other'
   END
;

-- Works in SQL Server Only:
SELECT
   IIF(ship_state IN ('CA', 'OR', 'WA'), 'West Coast', 'Other'),
   COUNT(*)
FROM orders
GROUP BY IIF(ship_state IN ('CA', 'OR', 'WA'), 'West Coast', 'Other');





-- 3. Write a conditional to divide users into 3 groups, based on their created_at: 
--    early for accounts created in 2019 (the entire year) or prior
--    middle for accounts created in 2020 (the entire year)
--    late for accounts created in 2021 or later
--    Reminder: If you do not specify hours for a datetime column, the hours default to 00:00:00
--    So be sure to cast the datetime as a date to go all the way through the end of the day.
SELECT
   CASE 
      WHEN ( CAST(created_at AS date) <= '2019-12-31') THEN 'early'
      WHEN ( CAST(created_at AS date) <= '2020-12-31') THEN 'middle'
      ELSE 'late'
   END AS user_type
FROM users;



-- 4. We want to count the number of orders made by each group in the query above.
--    The users table doesn't have order info, so the first step is to 
--    modify the last query and join in the orders table.
--    You will not see the newly joined data because we're only showing the CASE column,
--    but you'll need it the step below when we group the data.
--    NOTE: Because created_at exists in both tables, you'll need to
--    prefix the table name or alias (example: users.created_at)
SELECT
   CASE 
      WHEN ( CAST(u.created_at AS date) <= '2019-12-31') THEN 'early'
      WHEN ( CAST(u.created_at AS date) <= '2020-12-31') THEN 'middle'
      ELSE 'late'
   END AS user_type
FROM users AS u
JOIN orders AS o
ON u.user_id = o.user_id;


-- 5. Modify the query above, adding a GROUP BY to find which 
--    group of users made more orders: early, middle, or late.
SELECT
   CASE
      WHEN ( CAST(u.created_at AS date) <= '2019-12-31') THEN 'early'
      WHEN ( CAST(u.created_at AS date) <= '2020-12-31') THEN 'middle'
      ELSE 'late'
   END AS user_type,
   COUNT(*)
FROM users AS u
JOIN orders AS o
ON u.user_id = o.user_id
GROUP BY
   CASE
      WHEN ( CAST(u.created_at AS date) <= '2019-12-31') THEN 'early'
      WHEN ( CAST(u.created_at AS date) <= '2020-12-31') THEN 'middle'
      ELSE 'late'
   END
;

-- PostgreSQL Only: We can use an alias to make it easier to read (and much cleaner code)
SELECT
   CASE
      WHEN ( CAST(u.created_at AS date) <= '2019-12-31') THEN 'early'
      WHEN ( CAST(u.created_at AS date) <= '2020-12-31') THEN 'middle'
      ELSE 'late'
   END AS user_type,
   COUNT(*)
FROM users AS u
JOIN orders AS o
ON u.user_id = o.user_id
GROUP BY user_type;


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- 1. Get the number of orders on weekdays or weekends (per state they were shipped to).
--    Reminder for PostgreSQL: The day of week is numbered Sunday as 0, Saturday as 6.
--    Reminder for SQL Server: The day of week is numbered Sunday as 1, Saturday as 7.

-- PostgreSQL:
SELECT ship_state,
   CASE
      WHEN DATE_PART('dow', created_at) IN (0, 6) THEN 'weekend'
      ELSE 'weekday'
   END AS day_type,
   COUNT(*) 
FROM orders
GROUP BY ship_state, day_type
ORDER BY ship_state;


-- SQL Server: One approach using IIF
SELECT
   ship_state,
   IIF( DATEPART(dw, created_at) IN (1, 7), 'weekend', 'weekday') AS day_type,
   COUNT(*) 
FROM orders
GROUP BY
   ship_state,
   IIF( DATEPART(dw, created_at) IN (1, 7), 'weekend', 'weekday')
ORDER BY ship_state;


-- SQL Server: Another approach using CASE
SELECT ship_state,
   CASE
      WHEN DATEPART(dw, created_at) IN (1, 7) THEN 'weekend'
      ELSE 'weekday'
   END AS day_type,
   COUNT(*) 
FROM orders
GROUP BY
   ship_state, 
    CASE
      WHEN DATEPART(dw, created_at) IN (1, 7) THEN 'weekend'
      ELSE 'weekday'
   END
ORDER BY ship_state;