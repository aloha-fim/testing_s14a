-- Stored Procedures

-------------------------------------------------------------------
-- WARMUPS & REFERENCE
-------------------------------------------------------------------

/******************************************************/
-- PostgreSQL
/******************************************************/

-- Stored Procedures work differently in PostgreSQL than they do in SQL Server.
-- In PostgreSQL you probably want to use a function instead of a stored procedure (unless you’re managing transactions).


/******************************************************/
-- SQL Server
/******************************************************/

-- 1. Using a SQL Server System Stored Procedure:
EXEC sp_help users; -- users refers to our users table
EXEC sp_help orders; -- users refers to our orders table
EXEC sp_server_info;


-- 2. Create a New Stored Procedure:
--    NOTE: Make sure you select the database (in class that's noble_desktop) in the toolbar (to the left of Execute) before creating!
CREATE PROCEDURE spUsers_GetAll
AS
BEGIN
   SELECT *
   FROM users;
END;


-- 3. Call a Stored Procedure (2 different ways, both work the same):
EXEC spUsers_GetAll;
spUsers_GetAll;


-- 4. Alter a Stored Procedure:
ALTER PROCEDURE spUsers_GetAll
AS
BEGIN
   SELECT name, email
   FROM users
END;


-- 5. Call the Updated Stored Procedure:
EXEC spUsers_GetAll;


-- 6. Create a Stored Procedure with Variables:
CREATE PROCEDURE spUsers_GetByName
   @user_name AS varchar(255) -- AS is optional
AS
BEGIN
   SELECT *
   FROM users
   WHERE name LIKE @user_name
END;


-- 7. Call a Stored Procedure with Variables:
-- If you have multiple variables you separate them with a comma:
-- EXEC spName @var1 = value1, @var2 = value2;
EXEC spUsers_GetByName @user_name = 'Elma%';
EXEC spUsers_GetByName @user_name = 'Jay%';
EXEC spUsers_GetByName @user_name = '';


-- 8. Delete a Stored Procedure:
-- NOTE: DROP PROC also works
DROP PROCEDURE spUsers_GetAll;
DROP PROCEDURE spUsers_GetByName;


--------------------------------------------------------
-- EXERCISES: Answer using the techniques from above.
--------------------------------------------------------

-- 1. Turn the query below into a new stored procedure that lets you specify any 2 dates.
--    Test out the stored procedure to make sure it works as expected.
SELECT COUNT(*) AS "# of users"
FROM users
WHERE CAST(created_at AS DATE) BETWEEN '2020-09-21' AND '2020-12-20';

