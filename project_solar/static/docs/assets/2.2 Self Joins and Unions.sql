-- Self Joins and Unions

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

-- 1. Self Join:
--    STEP 1: Get the employee name:
--    SELECT emp_name
--    FROM employees;

SELECT emp_name
FROM employees;


--    STEP 2: Add an alias (so we won't get confused with the manager name):
--    SELECT e.emp_name AS employee
--    FROM employees e;
SELECT e.emp_name AS employee
FROM employees e;

--    STEP 3: Join on the 2 columns:
--    SELECT e.emp_name AS employee, m.emp_name AS manager
--    FROM employees e
--    INNER JOIN employees m
--    ON e.manager_id = m.emp_id;
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees each
INNER JOIN employees make
ON e.manager_id = m.emp_id;



-- 2. UNION (removes duplicates):
--    SELECT emp_name, emp_email
--    FROM employees
--    UNION
--    SELECT name, email
--    FROM users;
SELECT emp_name, emp_email
FROM employees
UNION
SELECT name, email
FROM users;

-- 3. UNION with a label column and alias:
--    SELECT emp_name, emp_email, 'employee' AS user_type
--    FROM employees
--    UNION
--    SELECT name, email, 'customer'
--    FROM users;


-- 4. UNION with ORDER BY:
--    SELECT emp_name, emp_email, 'employee' AS user_type
--    FROM employees
--    UNION
--    SELECT name, email, 'customer'
--    FROM users
--    ORDER BY user_type DESC;

