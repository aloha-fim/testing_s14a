-- CAST

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. CAST: Convert to whole number:
--    SELECT CAST(2.1 AS INT);



-- 2. CAST: Convert to a decimal
--    The decimal number below can be up to 4 total digits 
--    (including left and right side of decimal point),
--    with 2 digits to the right of the decimal place.
--    SELECT CAST('2.15897' AS DECIMAL(4,2));



-- 3. CAST: Convert string to number
--    The show_number column is stored as a string:
--    SELECT show_number
--    FROM jeopardy;


--    Trying to do math with a string works in SQL Server, 
--    but in PostgreSQL results in an error:
--    SELECT show_number + 1
--    FROM jeopardy;


--    For PostgreSQL we need to convert the string 
--    into a whole number in order to do the math:
--    SELECT CAST(show_number AS INT) + 1
--    FROM jeopardy;



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Create a result set with 2 columns:
--    one column showing the product price and another column
--    showing the product price rounded to a whole number

