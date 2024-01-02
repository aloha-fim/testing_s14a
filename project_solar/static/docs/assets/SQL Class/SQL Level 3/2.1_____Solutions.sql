-- Variables

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Convert the query below to use variables for the start and end dates:
DECLARE @start_date DATE;
DECLARE @end_date DATE;
SET @start_date = '2020-09-21';
SET @end_date   = '2020-12-20';
SELECT COUNT(*) AS "# of users"
FROM users
WHERE CAST(created_at AS DATE) BETWEEN @start_date AND @end_date;

