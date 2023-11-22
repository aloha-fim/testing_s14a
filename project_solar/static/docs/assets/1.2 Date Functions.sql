-- Date Functions

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Using DATE PART:
--    In PostgreSQL:
--    SELECT created_at, DATE_PART('hour', created_at) FROM orders;
--    SELECT created_at, DATE_PART('day', created_at) FROM orders;
--    SELECT created_at, DATE_PART('month', created_at) FROM orders;
--    SELECT created_at, DATE_PART('year', created_at) FROM orders;
--    SELECT created_at, DATE_PART('dow', created_at) FROM orders;
--    NOTE: In PostgreSQL Sunday = 0 Monday = 1 through Saturday = 6

--    In SQL Server (notice the lack of quotes around hour, day, etc):
--    SELECT created_at, DATEPART(hour, created_at) FROM orders;
--    SELECT created_at, DATEPART(day, created_at) FROM orders;
--    SELECT created_at, DATEPART(month, created_at) FROM orders;
--    SELECT created_at, DATEPART(year, created_at) FROM orders;
--    SELECT created_at, DATEPART(dw, created_at) FROM orders;
--    NOTE: In SQL Server Sunday = 1 Monday = 2 through Saturday = 7


-- 2. Getting the name of the month and day:
--    In PostgreSQL:
--    SELECT created_at, TO_CHAR(created_at, 'Month') FROM orders;
--    SELECT created_at, TO_CHAR(created_at, 'Day') FROM orders;
--    SELECT created_at, TO_CHAR(created_at, 'Dy') FROM orders;
--    SELECT created_at, TO_CHAR(created_at, 'DD') FROM orders;
--    SELECT created_at, TO_CHAR(created_at, 'YYYY') FROM orders;
--    Learn more about TO_CHAR:
--    https://www.postgresql.org/docs/current/functions-formatting.html

--    In SQL Server:
--    SELECT created_at, DATENAME(month, created_at) FROM orders;
--    SELECT created_at, DATENAME(dw, created_at) FROM orders;
--    SELECT created_at, FORMAT(created_at,'ddd') FROM orders;
--    SELECT created_at, FORMAT(created_at,'ddd, MMMM d, yyyy') FROM orders;
--    Learn more about DATENAME:
--    https://docs.microsoft.com/en-us/sql/t-sql/functions/datename-transact-sql?view=sql-server-ver16
--    Learn more about FORMAT:
--    https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings



-- 3. Get weekend orders:
--    In PostgreSQL: Sunday = 0 Monday = 1 through Saturday = 6
--    SELECT * FROM orders
--    WHERE DATE_PART('dow', created_at) IN (0, 6);

--    In SQL Server: Sunday = 1 Monday = 2 through Saturday = 7
--    SELECT * FROM orders
--    WHERE DATEPART(dw, created_at) IN (1, 7);



-- 4. Calculate the difference between 2 dates:
--    In PostgreSQL:
--    SELECT DATE_PART( 'year', NOW() ) - DATE_PART( 'year', created_at ) FROM orders;

--    In SQL Server:
--    SELECT DATEDIFF( year, created_at, GETDATE() ) FROM orders;



-- 5. Getting a date range:
--    SELECT COUNT(*) FROM orders
--    WHERE created_at BETWEEN '2021-01-01' AND '2022-02-01';


--    PROBLEM: If your column contains DATETIME and you do not specify hours when specifying the date,
--    the hours default to 00:00:00 so it does not go through the end of the last day!

--    SOLUTION: Convert to a date (instead of datetime which includes the time)
--    so you get the entire final day:
--    SELECT COUNT(*) FROM orders
--    WHERE CAST(created_at AS DATE) BETWEEN '2021-01-01' AND '2022-02-01';



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. How many years old, is the oldest user account?


-- 2. During which years were user accounts created?


-- 3. How many user accounts were created on a weekend?


-- 4. During which months in the first third of the year were user accounts created?


-- 5. How many user accounts were created September 21, 2020 to December 20, 2020?


