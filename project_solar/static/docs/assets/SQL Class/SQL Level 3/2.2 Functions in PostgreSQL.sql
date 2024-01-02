-- Functions in PostgreSQL

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- Let's look at Views again, so we can compare them to Functions

-- 1. Get info on all items purchased and the user id
SELECT *
FROM line_items li
JOIN orders o ON o.order_id = li.order_id;

-- 2. Get all items purchased by user 99
SELECT *
FROM line_items li
JOIN orders o ON o.order_id = li.order_id
WHERE user_id = 99;

-- 3. Exclude returned items
SELECT *
FROM line_items li
JOIN orders o ON o.order_id = li.order_id
WHERE user_id = 99
AND status != 'returned';

-- 4. Calculate the total dollar amount spent by that user (still excluding returned items)
SELECT SUM(price * quantity)
FROM line_items li
JOIN orders o ON o.order_id = li.order_id
WHERE user_id = 99
AND status != 'returned';

-- 5. Try to create a view, but it WILL FAIL because the 2 order_id columns have the same name.
CREATE VIEW all_orders_view AS
SELECT *
FROM line_items li
JOIN orders o ON o.order_id = li.order_id;

-- 6. Create view that will work by specifying only the columns we need
CREATE VIEW all_orders_view AS
SELECT li.order_id, user_id, price, quantity, status 
FROM line_items li
JOIN orders o ON o.order_id = li.order_id;

-- 7. See what's in the view
SELECT * FROM all_orders_view;

-- 8. Filter the view to only show user 99 and exclude returned items
SELECT *
FROM all_orders_view
WHERE user_id = 99
AND status != 'returned';

-- 9. SUM the filtered view
SELECT SUM(price * quantity)
FROM all_orders_view
WHERE user_id = 99
AND status != 'returned';
-- The above query works, but using a function, we could
-- make it easier for other people to use this (with less code).


-------------------------------------------------------------------
-- Creating Another View
-------------------------------------------------------------------

-- 1. Here's a query that calculates the total spent by each user
SELECT user_id, SUM(price * quantity)
FROM line_items li
JOIN orders o ON o.order_id = li.order_id
WHERE status != 'returned'
GROUP BY user_id;

-- 2. Save the above query as a View
CREATE VIEW total_spent_per_user_view AS
SELECT user_id, SUM(price * quantity)
FROM line_items li
JOIN orders o ON o.order_id = li.order_id
WHERE status != 'returned'
GROUP BY user_id;

-- 3. See everything in the View
SELECT * FROM total_spent_per_user_view;

-- 4. Filter the View
SELECT * FROM total_spent_per_user_view
WHERE user_id = 99;

-- This View works, but the problem is it calculates the total spent for every user.
-- If you have a lot of users, this can be very intensive when you only want the total for a single user!


-------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------

-- 1. Create a Function that returns a single value
CREATE FUNCTION fn_get_user_total_spent( the_user INT )
RETURNS DECIMAL(9,2)
AS
$$
   SELECT SUM(price * quantity)
   FROM line_items li
   JOIN orders o ON o.order_id = li.order_id
   WHERE user_id = the_user
   AND status != 'returned';
$$
LANGUAGE sql;


-- 2. Call a Function
-- Calling the function is very clean code, making it easier for others to use.
SELECT * FROM fn_get_user_total_spent(99);
SELECT fn_get_user_total_spent(99);


-- 3. Delete a Function
DROP FUNCTION fn_get_user_total_spent;


-- 4. Create a Function that returns multiple columns
CREATE FUNCTION fn_get_user_total_spent_and_total_quantity( the_user INT )
RETURNS TABLE( total_quantity INT, total_spent DECIMAL(9,2) )
AS
$$
   SELECT
      SUM(quantity) AS total_quantity,
      SUM(price * quantity) AS total_spent
   FROM line_items li
   JOIN orders o ON o.order_id = li.order_id
   WHERE user_id = the_user
   AND status != 'returned';
$$
LANGUAGE sql;


-- 5. Call the Function
-- This function returns a table, so query it like a table.
SELECT * FROM fn_get_user_total_spent_and_total_quantity(99);


-- 6. Delete the Function
DROP FUNCTION fn_get_user_total_spent_and_total_quantity;
