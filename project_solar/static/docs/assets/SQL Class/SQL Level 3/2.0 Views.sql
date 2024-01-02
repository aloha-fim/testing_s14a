-- Views

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Create a View:
--    NOTE: It's recommended to include 'view' in the name so when using it,
--    it's clear that you're using a view rather than a table.

--    SQL Server: Make sure you select the database (in class that's noble_desktop) in the toolbar (to the left of Execute) before creating!

--    CREATE VIEW gmail_view AS
--    SELECT * FROM users
--    WHERE email like '%gmail.com';

--    NOTE: You must refresh the views list after creating 
--    (Right-click on Views and choose Refresh)





-- 2. Query a View:
--    SELECT * FROM gmail_view;

--    NOTE: See how if you didn't have 'view' in the name of the view
--    it would be unclear whether you're querying a table or a view?



-- 3. Filter the results from a View:
--    SELECT * FROM gmail_view
--    WHERE user_state = 'ID';

--    In PostgreSQL:
--    SELECT * FROM gmail_view
--    ORDER BY created_at DESC
--    LIMIT 5;

--    In SQL Server:
--    SELECT TOP(5) * FROM gmail_view
--    ORDER BY created_at DESC;



-- 4. To Alter an View:
--    PostgreSQL (DBeaver):
--    Editing Postgres views is limited. For example you cannot remove columns from an existing view.
--    In most cases it's best/required to delete and then recreate the view.
--    A. Double-click the name of a view
--    B. Make sure you're in the "Properties" tab (at the top).
--    C. Click on the "Source" category/tab.
--    D. Edit the query.
--    E. At the bottom right click Save.
--    F. In the dialog that opens, click Persist.

--    SQL Server:
--    A. In the Object Explorer Right-click on the name of the view
--       and choose Script View as > Alter To > New Query Editor Window.
--    B. Edit the query.
--    C. Select all the code in the file and Execute it.



-- 5. Delete a View:
--    DROP VIEW gmail_view;

--    NOTE: You must refresh the views list after deleting
--    (Right-click on Views and choose Refresh)




-- 5. PostgreSQL Only: Materialized Views:

--    4A: Create a Materialized View
--    CREATE MATERIALIZED VIEW gmail_mview AS
--    SELECT * FROM users
--    WHERE email like '%gmail.com';

--    4B: Query a Materialized View
--    SELECT * FROM gmail_mview;

--    4C: Refresh the data in a Materialized View
--    REFRESH MATERIALIZED VIEW gmail_mview;

--    4D: Delete a Materialized View
--    DROP MATERIALIZED VIEW gmail_mview;



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Find out how much money each user has spent in total, but using a view. 
-- Let's go through the process step by step.
-- Step A: Join the orders and line_items tables (on the order_id column):


--- Step B: Try to save it as a view (it will give an error because the 2 order_id columns have the same name):


--- Step C: Rewrite the join by specifying all the columns, giving an alias to the list_items table's order_id (so it's li_order_id):


--- Step D: Save the updated join as a view and it will work!


--- Step E: Query the view to find out how much money each user has spent in total (you'll have to use a GROUP BY)
