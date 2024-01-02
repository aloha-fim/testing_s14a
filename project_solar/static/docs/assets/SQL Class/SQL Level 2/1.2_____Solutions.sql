-- Date Functions

----------------------------
-- SOLUTIONS to Exercises
----------------------------

/******************************************************/
-- PostgreSQL
/******************************************************/

-- 1. How many years old, is the oldest user account?
SELECT MAX( (DATE_PART('year', NOW()) - DATE_PART('year', created_at) ) )
FROM users;

-- 2. During which years were user accounts created?
SELECT DISTINCT DATE_PART('year', created_at)
FROM users
ORDER BY date_part;

-- 3. How many user accounts were created on a weekend?
SELECT COUNT(*) FROM users
WHERE DATE_PART('dow', created_at) IN (0, 6);

-- 4. During which months in the first third of the year were user accounts created?
SELECT DISTINCT DATE_PART('month', created_at), TO_CHAR(created_at, 'Month')
FROM users
WHERE DATE_PART('month', created_at) <= 4
ORDER BY date_part;

-- 5. How many user accounts were created September 21, 2020 to December 20, 2020?
SELECT COUNT(*) FROM users
WHERE CAST(created_at AS DATE) BETWEEN '2020-09-21' AND '2020-12-20';


/******************************************************/
-- SQL Server
/******************************************************/

-- 1. How many years old, is the oldest user account?
SELECT MAX( DATEDIFF( year, created_at, GETDATE() ) )
FROM users;

-- 2. During which years were user accounts created?
SELECT DISTINCT DATEPART(year, created_at)
FROM users;

-- 3. How many user accounts were created on a weekend?
SELECT COUNT(*) FROM users
WHERE DATEPART(dw, created_at) IN (1, 7);

-- 4. During which months in the first third of the year were user accounts created?
SELECT DISTINCT DATEPART(month, created_at), DATENAME(month, created_at)
FROM users
WHERE DATEPART(month, created_at) <= 4;

-- 5. How many user accounts were created September 21, 2020 to December 20, 2020?
SELECT COUNT(*) FROM users
WHERE CAST(created_at AS DATE) BETWEEN '2020-09-21' AND '2020-12-20';
