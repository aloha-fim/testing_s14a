-- Functions in SQL Server

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- Let's look at Views again, so we can compare them to Functions

-- 1. Get info on all items purchased and the listing id
SELECT *
FROM listing_post li
JOIN listing_second_post ls ON ls.id = li.id;

-- 2. Get all items purchased by user 99
SELECT *
FROM listing_post li
JOIN listing_second_post ls ON ls.id = li.id
WHERE user_id = 99;

-- 3. Exclude returned items
SELECT *
FROM listing_post li
JOIN listing_second_post ls ON li.id = ls.id
WHERE user_id = 99
AND status != 'returned';

-- 4. Calculate the total dollar amount spent by that user (still excluding returned items)
SELECT SUM(room_price * quantity)
FROM listing_post li
JOIN listing_second_post ls ON li.id = ls.id
WHERE user_id = 99
AND status != 'returned';

-- 5. Try to create a view, but it WILL FAIL because the 2 order_id columns have the same name.
-- Make sure you select the database (in class that's noble_desktop) in the toolbar (to the left of Execute) before creating!
CREATE VIEW all_orders_view AS
SELECT *
FROM listing_post li
JOIN listing_post ls ON li.id = ls.id;

-- 6. Create view that will work by specifying only the columns we need
CREATE VIEW all_orders_view AS
SELECT li.id, user_id, room_price, quantity, discount
FROM listing_post li
JOIN listing_second_post ls ON li.id = ls.id;

-- 7. See what's in the view
SELECT * FROM all_orders_view;

-- 8. Filter the view to only show user 99 and exclude returned items or discount not 5
SELECT *
FROM all_orders_view
WHERE user_id = 99
AND status != 'returned';

SELECT * 
FROM all_orders_view
WHERE user_id = 99
AND discount != 5;

-- 9. SUM the filtered view
SELECT SUM(price * quantity)
FROM all_orders_view
WHERE user_id = 99
AND status != 'returned';

SELECT SUM(room_price * quantity)
FROM all_orders_view
WHERE user_id = 99
AND discount != 5;
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

SELECT user_id, SUM(price * quantity)
FROM listing_post li
JOIN listing_second_post ls ON li.id = ls.id
WHERE discount != 5
GROUP BY user_id;

-- 2. Save the above query as a View
CREATE VIEW total_spent_per_user_view AS
SELECT user_id, SUM(price * quantity) AS total_spent
FROM line_items li
JOIN orders o ON o.order_id = li.order_id
WHERE status != 'returned'
GROUP BY user_id;

CREATE VIEW total_spent_per_user_view AS
SELECT user_id, SUM(price * quantity) AS total_spent
FROM listing_post li
JOIN listing_second_post ls ON li.id = ls.id
WHERE discount != 5
GROUP BY user_id;

-- 3. See everything in the View
SELECT * FROM total_spent_per_user_view;

-- 4. Filter the View
SELECT * FROM total_spent_per_user_view
WHERE user_id = 99;

-- This view works, but the problem is it calculates the total spent for every user.
-- If you have a lot of users, this can be very intensive when you only want the total for a single user!


-------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------


-- 1. Scalar Functions: Create a Function that returns a single value
-- Make sure you select the database (in class that's noble_desktop) in the toolbar (to the left of Execute) before creating!
CREATE FUNCTION fn_get_user_total_spent( @the_user INT )
RETURNS DECIMAL(9,2)
AS
BEGIN
   RETURN (
      SELECT SUM(price * quantity)
      FROM line_items li
      JOIN orders o ON o.order_id = li.order_id
      WHERE user_id = @the_user
      AND status != 'returned'
   )
END;
-- This can be found in noble_desktop > Programmability > Functions > Scalar-valued Functions
-- (you may need to refresh the list by Right-clicking on that folder and choosing Refresh)
CREATE FUNCTION fn_get_user_total_spent ( @the_user INT)
RETURN DECIMAL (9,2)
AS
BEGIN
    RETURN (
        SELECT SUM(price * quantity)
        FROM listing_post li
        JOIN listing_second_post ls ON li.id =ls.id
        WHERE user_id = @the_user
        AND discount != 5
    )
END;

-- 2. Call a Function
-- Calling the function is very clean code, making it easier for others to use.
SELECT dbo.fn_get_user_total_spent(99);
-- 3. Delete a Function
DROP FUNCTION fn_get_user_total_spent;

-- 4. Table-Valued Functions: Create a Function that returns multiple columns
-- Notice there's no BEGIN and END for this.
CREATE FUNCTION fn_get_user_total_spent_and_total_quantity( @the_user INT )
RETURNS TABLE
AS
RETURN (
   SELECT
      SUM(quantity) AS total_quantity,
      SUM(price * quantity) AS total_spent
   FROM line_items li
   JOIN orders o ON o.order_id = li.order_id
   WHERE user_id = @the_user
   AND status != 'returned'
);
-- This can be found in noble_desktop > Programmability > Functions > Table-valued Functions
-- (you may need to refresh the list by Right-clicking on that folder and choosing Refresh)
CREATE FUNCTION fn_get_user_total_spent_and_total_quantity (@the_user INT)
RETURNS TABLE
AS
RETURN (
    SELECT(quantity) AS total_quantity, SUM(price * total_quantity) AS total_spent
    FROM listing_post li
    JOIN listing_second_post ls ON li.id = ls.id
    WHERE user_id = @the_user
    AND discount != 5
);

-- 5. Call the Function
-- This function returns a table, so query it like a table.
SELECT * FROM fn_get_user_total_spent_and_total_quantity(99);

