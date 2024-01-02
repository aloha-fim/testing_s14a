-- Modifying Tables

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. To practice cleaning data in SQL, let's say Yahoo email addresses are switching to Verizon.
--    First, SELECT all the Yahoo email addresses in the users table.
SELECT * FROM users
WHERE email LIKE '%yahoo.com';


-- 2. Using the WHERE clause from the last question, 
--    do an UPDATE, setting the 'email' column to the new Verizon version using REPLACE(). 
--    Remember to use transactions when doing an UPDATE.
--    Be sure to use BEGIN, test the change, and then commit.
BEGIN;
   UPDATE users
   SET email = REPLACE(email, 'yahoo', 'verizon')
   WHERE email ILIKE '%yahoo.com';

   SELECT email FROM users
   WHERE email ILIKE '%yahoo.com' OR email ILIKE '%verizon.com'

COMMIT;


-- 3. For more practice, let's say all watches are now smart watches. 
--    First, SELECT all the products that contain the word Watch in them.
SELECT * FROM products
WHERE title ILIKE '%Watch';


-- 4. Using the WHERE clause from the last question, 
--    do an UPDATE, setting the 'title' column to the new version substituting 'Smart Watch' for 'Watch'. 
--    Remember to use transactions when doing an UPDATE.
BEGIN;
   UPDATE products
   SET title = REPLACE(title, 'Watch', 'Smart Watch')
   WHERE title LIKE '%Watch';

SELECT * FROM products
WHERE title ILIKE '%Watch';

COMMIT;