-- Transactions

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Begin Transaction and Insert (NOTE: We use DEFAULT for the auto-incrementing primary key)
--    BEGIN;
--    INSERT INTO products
--    VALUES
--       ( DEFAULT, 'Cotton Shirt', 19.95, 'red', NOW() );


-- 2. Preview the change (this will not show up if you go to into the table's Data tab):
--    SELECT * FROM products;


-- 3. Either Undo or Save the Transaction: 
--    Undo Transaction: 
--    ROLLBACK;


--    Save Transaction (you can also use END):
--    COMMIT; 


-- 4. See the change after you've saved or undone it:
--    SELECT * FROM products;



--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Add yourself to the users table. You can leave the password blank (NULL).
--    Pay attention to data type. For example user_zipcode is a string, not a number!
--    Use BEGIN, preview the change as you go, and only commit when it looks good.


-- 2. Add a new row to the orders table, using your user_id (which should be 101) as a foreign key.


-- 3. Insert a $4.99 'Coloring Book' into the products table.
--    Use the syntax where you only specify the columns you want to insert,
--    which in this case are: title, price, and created_at


