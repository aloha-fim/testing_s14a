-- String Functions

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Create a list of the unique email domain names (the gmail.com, yahoo.com part) for all users.
-- PostgreSQL
SELECT DISTINCT SPLIT_PART(email,'@',2) as email_domain
FROM users;

-- SQL SERVER
SELECT DISTINCT SUBSTRING( email, CHARINDEX('@', email) + 1, LEN(email) ) as email_domain
FROM users;



-- 2. How many users have each email domain name?
-- PostgreSQL
SELECT
   SPLIT_PART(email,'@',2) as email_domain,
   COUNT(*)
FROM users
GROUP BY email_domain;

-- SQL SERVER
SELECT
   SUBSTRING( email, CHARINDEX('@', email) + 1, LEN(email) ) as email_domain,
   COUNT(*)
FROM users
GROUP BY
   SUBSTRING( email, CHARINDEX('@', email) + 1, LEN(email) )
;

