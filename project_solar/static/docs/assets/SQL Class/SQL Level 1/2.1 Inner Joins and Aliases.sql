-- Inner Joins and Aliases

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Inner Join (or simply JOIN, which returns matching rows):
--    SELECT * FROM employees
--    JOIN departments 
--    ON employees.dept_id = departments.dept_id; 


-- 2. Only including the columns you want:
--    SELECT emp_name, dept_name FROM employees
--    JOIN departments
--    ON employees.dept_id = departments.dept_id; 


-- 3. When referring to a column that exists in both tables (like dept_id) you MUST specify the table name:
--    TIP: Usually you refer to the column that is the primary key.
--    SELECT emp_name, dept_name, departments.dept_id FROM employees
--    JOIN departments
--    ON employees.dept_id = departments.dept_id; 


-- 4. Using aliases to make the code more efficient:
--    SELECT * FROM employees e
--    JOIN departments d 
--    ON e.dept_id = d.dept_id; 


-- 5. Using aliases for the column names:
--    NOTE: For columns that only exist in one table you don't need the table alias,
--    but adding the alias makes it clearer where the data comes from.
--    SELECT e.emp_name, d.dept_name, d.dept_id FROM employees e
--    JOIN departments d 
--    ON e.dept_id = d.dept_id; 


-- 6. Using an alias in a filter (to find all employees who work in sales):
--    SELECT e.emp_name, d.dept_name FROM employees e
--    JOIN departments d 
--    ON e.dept_id = d.dept_id
--    WHERE d.dept_name = 'Sales';


-- 7. Joining more than two tables. 
--    SELECT * FROM users u
--    JOIN orders o ON u.user_id = o.user_id
--    JOIN line_items li ON o.order_id = li.order_id;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- Let's find the name and email of people who ordered a total of $700 or more.
-- We'll walk you through building up the query over several steps.

-- 1. Select everything from the line_items table.
-- In the results, notice it contains the price and quantity, but not who ordered.


-- 2. Join the line_items table to the orders table (on the order_id column)
-- In the results, notice you can now see price, quantity, and user_id.


-- 3. We want to get the user's name, so continuing with the previous query,
-- also join in the users table (on the user_id column).
-- In the results, notice you can now see the price, quantity, and name of the user.


-- 4. Continuing with the previous query, filter the results to show 
-- just the name and email of people who ordered a total of $700 or more.
-- Don't forget that involves math for quantity times price.

