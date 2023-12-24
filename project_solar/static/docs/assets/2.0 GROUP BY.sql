-- GROUP BY

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Grouping by one column:
--    SELECT ship_state, COUNT(*)
--    FROM orders
--    GROUP BY ship_state;

-- FI
    SELECT listing_type, COUNT(*)
    FROM listing_post
    GROUP BY listing_type;


-- 2. Grouping by multiple columns:
--    SELECT ship_state, ship_zipcode, COUNT(*)
--    FROM orders
--    GROUP BY ship_state, ship_zipcode
--    ORDER BY ship_state;
    SELECT amount_land, listing_type, COUNT(*)
    FROM listing_post
    GROUP BY amount_land, listing_type
    ORDER BY amount_land;


-- 3. Grouping by multiple columns, ignoring the last 4 digits in zipcode:
--    SUBSTRING() accepts 3 parameters: the string, the starting character, how many total characters you want
--    SELECT ship_state, SUBSTRING(ship_zipcode,1,5), COUNT(*)
--    FROM orders
--    GROUP BY ship_state, SUBSTRING(ship_zipcode,1,5)
--    ORDER BY ship_state;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. When was the most recent order made in each state?


-- 2. Use the line_items table to find the total number of each product_id sold.
--    Make sure you exclude returned and canceled from your results.


-- 3. Use the line_items table to see the total dollar amount of items in each status (returned, shipped, etc.)


-- 4. In the products table, find how many products are under each set of tags.


-- 5. Modify the previous query to find how many products over $70 are under each set of tags.


-- 6. Use the orders table to find out how many orders each user made.


-- 7. What is the first order that was made in each state, in each zipcode?
--    Zipcodes do not repeat between states, but write your query as though they do
--    because it's nice to see the state for context.


----------------------------------------
-- EXTRA CREDIT: If you finish early.
----------------------------------------

-- REMINDER: Use DATE_PART() in PostgreSQL or DATEPART() in SQL Server

-- 1. Use DATE PART to extract which calendar month each user was created in.


-- 2. Use DATE PART and a GROUP BY statement to count how many users were created in each calendar month.


-- 3. Use DATE PART to find the number of users created during each day of the week.

