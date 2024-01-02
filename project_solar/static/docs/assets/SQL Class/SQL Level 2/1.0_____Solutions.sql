-- CAST

----------------------------
-- SOLUTIONS to Exercises
----------------------------

-- 1. Create a result set with 2 columns:
--    one column showing the product price and
--    another column showing the product price rounded to a whole number

SELECT price, CAST(price AS INT) AS rounded_price
FROM products;