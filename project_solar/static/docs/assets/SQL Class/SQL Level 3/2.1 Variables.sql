-- Variables

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

/******************************************************/
-- PostgreSQL
/******************************************************/

-- Postgres does not have variables that can be used by themselves, outside of functions.
-- There are workarounds, but most of them are clunky.


/******************************************************/
-- SQL Server
/******************************************************/

-- 1. SQL Server: Create and use variables:
DECLARE @user_name varchar(255);
SET @user_name = 'Anna%';
SELECT * FROM users
WHERE name LIKE @user_name;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Convert the query below to use variables for the start and end dates:
SELECT COUNT(*) AS "# of users"
FROM users
WHERE CAST(created_at AS DATE) BETWEEN '2020-09-21' AND '2020-12-20';

