-- GROUP BY with HAVING

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Group by using a HAVING filter:
--    Find states that have 10 or more orders:
--    SELECT ship_state, COUNT(*)
--    FROM orders 
--    GROUP BY ship_state 
--    HAVING COUNT(*) >= 10;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--            (These use the jeopardy table.)         --
--------------------------------------------------------

-- 1. Find the combined value of all questions for each air_date.


-- 2. Add a HAVING clause to the last query to find the dates 
--    when all the questions had a combined value < 10,000


-- 3. Find the value of the highest-value question for each show_number.


-- 4. Which shows had a question worth more than $2000?


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

--    To get the number of characters in a string:
--    In PostgreSQL: SELECT LENGTH(question) FROM jeopardy;
--    In SQL Server: SELECT LEN(question) FROM jeopardy;

-- 1. Display the air_date and "average" question length (number of characters)
--    ordered from longest (on top) to shortest.


