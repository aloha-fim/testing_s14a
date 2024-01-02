-- String Functions

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Converting Case:
--    SELECT UPPER(tags) 
--    FROM products;


-- 2. Get Part of a String:
--    Get first 5 characters of the zipcode
--    SELECT
--       ship_zipcode, 
--       SUBSTRING(ship_zipcode,1,5)
--    FROM orders;

--    Get the last 4 characters of the zipcode (after the -)
--    SELECT
--       ship_zipcode, 
--       SUBSTRING(ship_zipcode,7,4)
--    FROM orders;


-- 3. PostgreSQL Only: Splitting Strings:
--    Get the first part of the split string:
--    SELECT
--       ship_zipcode,
--       SPLIT_PART(ship_zipcode,'-',1)
--    FROM orders;

--    Get the second part of the split string:
--    SELECT
--       ship_zipcode,
--       SPLIT_PART(ship_zipcode,'-',2)
--    FROM orders;


-- 4. Other Ways to Split Strings:

-- Get the first 5 characters (starting from the left)
SELECT
   ship_zipcode,
   LEFT(ship_zipcode, 5)
FROM orders;

-- Get the last 4 characters (starting from the right).
-- This does get the right-most 4 characters, 
-- but it's not the 4 characters to the right of the dash.
SELECT
   ship_zipcode,
   RIGHT(ship_zipcode, 4)
FROM orders;

-- If the zipcode has more than 5 characters,
-- then get the right 4 characters, otherwise return an empty string
-- PostgreSQL:
SELECT
   ship_zipcode,
   CASE
      WHEN LENGTH(ship_zipcode) > 5 THEN RIGHT(ship_zipcode, 4)
      ELSE ''
   END
FROM orders;

-- SQL Server Only:
SELECT
   ship_zipcode,
   IIF( LEN(ship_zipcode) > 5, RIGHT(ship_zipcode, 4), '')
FROM orders;


/******************************************************/
-- SQL Server
/******************************************************/

--  SQL Server: Get the number of a character's location within a string
SELECT
   email, 
   CHARINDEX('@', email)
FROM users
ORDER BY 2;

-- SQL Server: Get everything starting from the left, up to that character location
SELECT
   email,
   LEFT( email, CHARINDEX('@', email) )
FROM users;

-- SQL Server: Subtract 1 to omit the @ character
SELECT
   email,
   LEFT( email, CHARINDEX('@', email) -1 )
FROM users;

--SQL Server: Use a substring to grab from the @ character to the end of the email
-- we use the length of the email to know what the last character is
SELECT
   email,
   SUBSTRING( email, CHARINDEX('@', email) + 1, LEN(email) )
FROM users;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Create a list of the unique email domain names (the gmail.com, yahoo.com part) for all users.


-- 2. How many users have each email domain name?

