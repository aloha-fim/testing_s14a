-- GROUP BY with HAVING

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Find the combined value of all questions for each air_date.
SELECT air_date, SUM(value) 
FROM jeopardy 
GROUP BY air_date;

-- 2. Add a HAVING clause to the last query to find the dates 
--    when all the questions had a combined value < 10,000
SELECT air_date, SUM(value) 
FROM jeopardy 
GROUP BY air_date
HAVING SUM(value) < 10000;

-- 3. Find the value of the highest-value question for each show_number.
SELECT show_number, MAX(value) 
FROM jeopardy 
GROUP BY show_number;

-- 4. Which shows had a question worth more than $2000?
SELECT show_number, MAX(value) 
FROM jeopardy 
GROUP BY show_number
HAVING MAX(value) > 2000;

----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

--    To get the number of characters in a string:
--    In PostgreSQL: SELECT LENGTH(question) FROM jeopardy;
--    In SQL Server: SELECT LEN(question) FROM jeopardy;

-- 1. Display the air_date and "average" question length (number of characters)
--    ordered from longest (on top) to shortest.

/******************************************************/
-- PostgreSQL
/******************************************************/

-- Accurate ordering, but numbers are not rounded
SELECT air_date, AVG(LENGTH(question)) AS avg_length
FROM jeopardy
GROUP BY air_date
ORDER BY avg_length DESC;

-- Less accurate ordering: AVG has been rounded to whole numbers, so ordering has changed
SELECT air_date, ROUND( AVG(LENGTH(question)) ) AS avg_length
FROM jeopardy
GROUP BY air_date
ORDER BY avg_length DESC;

-- Accurate ordering with rounded numbers: Order by the AVG with decimal values
-- It's best to only round the data we see, not the data we order by 
-- so we're ordering by the more accurate decimal numbers
SELECT air_date, ROUND( AVG(LENGTH(question)) ) AS avg_length
FROM jeopardy
GROUP BY air_date
ORDER BY AVG(LENGTH(question)) DESC;



/******************************************************/
-- SQL Server
/******************************************************/

-- Less accurate: AVG rounds to whole numbers
SELECT air_date, AVG(LEN(question)) AS avg_length
FROM jeopardy
GROUP BY air_date
ORDER BY avg_length DESC;

-- Accurate ordering: Make AVG use decimal values
-- You can see there's a difference in order starting at record #10
SELECT air_date, 
   AVG(
      CAST(
         LEN(question) AS DECIMAL(5,2)
      ) 
   ) AS avg_length
FROM jeopardy
GROUP BY air_date
ORDER BY avg_length DESC;

-- Accurate ordering with rounded numbers: Order by the AVG with decimal values
-- It's best to only round the data we see, not the data we order by 
-- so we're ordering by the more accurate decimal numbers
SELECT air_date,
   CAST(
      AVG(
         CAST( LEN(question) AS DECIMAL(5,2) )
      )
   AS INT) AS avg_length
FROM jeopardy
GROUP BY air_date
ORDER BY AVG( CAST( LEN(question) AS DECIMAL(5,2) ) ) DESC;
