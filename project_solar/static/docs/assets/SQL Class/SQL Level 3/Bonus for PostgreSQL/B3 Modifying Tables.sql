-- Modifying Tables

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Replace: 
--    SELECT REPLACE(title, 'Computer', 'Laptop')
--    FROM products;


-- 2. Update a product title:
--    Step 1: Begin the transaction and change the title
--    BEGIN;
--    SET title = 'Large Tennis Bag'
--    WHERE title = 'Small Marble Bag';

--    Step 2: Preview the changed product to make sure it worked properly:
--    SELECT * FROM products
--    WHERE title = 'Large Tennis Bag' OR title = 'Small Marble Bag';

--    Step 3: If the change looks good, commit the changes (otherwise do ROLLBACK):
--    COMMIT;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. To practice cleaning data in SQL, let's say Yahoo email addresses are switching to Verizon.
--    First, SELECT all the Yahoo email addresses in the users table.


-- 2. Using the WHERE clause from the last question, 
--    do an UPDATE, setting the 'email' column to the new Verizon version using REPLACE(). 
--    Remember to use transactions when doing an UPDATE.
--    Be sure to use BEGIN, test the change, and then commit.


-- 3. For more practice, let's say all watches are now smart watches. 
--    First, SELECT all the products that contain the word Watch in them.


-- 4. Using the WHERE clause from the last question, 
--    do an UPDATE, setting the 'title' column to the new version substituting 'Smart Watch' for 'Watch'. 
--    Remember to use transactions when doing an UPDATE.

