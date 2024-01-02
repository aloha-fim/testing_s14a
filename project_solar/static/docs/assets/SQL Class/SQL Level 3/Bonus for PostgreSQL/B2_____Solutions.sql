-- Transactions

----------------------------
-- SOLUTIONS to Exercises
----------------------------

/******************************************************/
-- PostgreSQL
/******************************************************/

-- 1. Add yourself to the users table. You can leave the password blank (NULL).
--    Pay attention to data type. For example user_zipcode is a string, not a number!
--    Use BEGIN, preview the change as you go, and only commit when it looks good.
BEGIN;
INSERT INTO users
VALUES (DEFAULT, 'John Smith', 'john@gmail.com', NULL, '123 Street', 'New York', 'NY', '10016', NOW());

SELECT * FROM users;
COMMIT;


-- 2. Add a new row to the orders table, using your user_id (which should be 101) as a foreign key.
BEGIN;
INSERT INTO orders
VALUES (DEFAULT, 101, NOW(), 'John Jacobs', '123 Street', 'New York', 'NY', '10016');

SELECT * FROM orders;
COMMIT;


-- 3. Insert a $4.99 'Coloring Book' into the products table.
--    Use the syntax where you only specify the columns you want to insert,
--    which in this case are: title, price, and created_at
BEGIN;
INSERT INTO products (title, price, created_at)
VALUES ( 'Coloring Book', 4.99, NOW() );

SELECT * FROM products;
COMMIT;


/******************************************************/
-- SQL Server
/******************************************************/

-- 1. Add yourself to the users table. You can leave the password blank (NULL).
--    Pay attention to data type. For example user_zipcode is a string, not a number!
--    Use BEGIN, preview the change as you go, and only commit when it looks good.
BEGIN;
INSERT INTO users
VALUES (DEFAULT, 'John Smith', 'john@gmail.com', NULL, '123 Street', 'New York', 'NY', '10016', GETDATE());

SELECT * FROM users;
COMMIT;


-- 2. Add a new row to the orders table, using your user_id (which should be 101) as a foreign key.
BEGIN;
INSERT INTO orders
VALUES (DEFAULT, 101, GETDATE(), 'John Jacobs', '123 Street', 'New York', 'NY', '10016');

SELECT * FROM orders;
COMMIT;


-- 3. Insert a $4.99 'Coloring Book' into the products table.
--    Use the syntax where you only specify the columns you want to insert,
--    which in this case are: title, price, and created_at
BEGIN;
INSERT INTO products (title, price, created_at)
VALUES ( 'Coloring Book', 4.99, GETDATE() );

SELECT * FROM products;
COMMIT;