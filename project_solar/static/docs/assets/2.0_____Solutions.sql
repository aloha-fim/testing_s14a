-- Views

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Find out how much money each user has spent in total, but using a view. 
-- Let's go through the process step by step.
-- Step A: Join the orders and line_items tables (on the order_id column):
SELECT *
FROM orders o JOIN line_items li
ON o.order_id = li.order_id;

--- Step B: Try to save it as a view (it will give an error because the 2 order_id columns have the same name):
CREATE VIEW user_totals_view AS
SELECT *
FROM orders o JOIN line_items li
ON o.order_id = li.order_id;

--- Step C: Rewrite the join by specifying all the columns, giving an alias to the list_items table's order_id (so it's li_order_id):
SELECT
   o.order_id, user_id, created_at, ship_name, ship_address, ship_city, ship_state, ship_zipcode, 
   line_item_id, product_id, price, quantity, status
FROM orders o JOIN line_items li
ON o.order_id = li.order_id;

--- Step D: Save the updated join as a view and it will work!
CREATE VIEW user_totals_view AS
SELECT
   o.order_id, user_id, created_at, ship_name, ship_address, ship_city, ship_state, ship_zipcode, 
   line_item_id, product_id, price, quantity, status
FROM orders o JOIN line_items li
ON o.order_id = li.order_id;

--- Step E: Query the view to find out how much money each user has spent in total (you'll have to use a GROUP BY)
SELECT user_id, SUM(price * quantity)
FROM user_totals_view
GROUP BY user_id;

