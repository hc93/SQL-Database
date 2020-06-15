-- Write an SQL query to find the prices of all products on 2019-08-16.
-- Assume the price of all products before any change is 10.

-- Two cases:
-- 1. Latest change date <= 2019-08-16 --> select from the table
-- 2. Latest change date > 2019-08-16 --> price = 10 before any change


-- My original solution:

  (SELECT product_id, new_price AS price
  FROM Products
  WHERE (product_id, change_date) IN
    ( SELECT product_id, MAX(change_date) AS latest_change_date
      FROM Products
      WHERE change_date <= '2019-08-16'
      GROUP BY product_id
    ))
UNION
  ( SELECT product_id, 10 AS price
    FROM Products
    WHERE product_id NOT IN (SELECT product_id FROM Products
                           WHERE change_date <= '2019-08-16'))


-- Another solution (optimized):

( SELECT product_id, 10 AS price
  FROM Products
  GROUP BY product_id
  HAVING MIN(change_date) > '2019-08-16')
UNION
 (
  SELECT p.product_id, p.new_price AS price
  FROM Products p
  WHERE (p.product_id, p.change_date) IN
    (
      SELECT product_id, MAX(change_date) AS latest_change_date
      FROM Products
      WHERE change_date <= '2019-08-16'
      GROUP BY product_id )
  )
