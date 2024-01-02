-- Stored Procedures

----------------------------
-- SOLUTIONS to Exercises
----------------------------

/******************************************************/
-- SQL Server
/******************************************************/

-- 1. Turn the query below into a new stored procedure that lets you specify any 2 dates.
--    Test out the stored procedure to make sure it works as expected.
SELECT COUNT(*) AS "# of users"
FROM users
WHERE CAST(created_at AS DATE) BETWEEN '2020-09-21' AND '2020-12-20';

-- Create the stored procedure
CREATE PROCEDURE spUsers_Total_In_Date_Range
   @start_date AS DATE,
   @end_date AS DATE
AS
BEGIN
   SELECT COUNT(*) AS "# of users"
   FROM users
   WHERE CAST(created_at AS DATE) BETWEEN @start_date AND @end_date;
END;

-- Call the stored procedure
EXEC spUsers_Total_In_Date_Range @start_date = '2019-01-01', @end_date = '2020-12-31';

