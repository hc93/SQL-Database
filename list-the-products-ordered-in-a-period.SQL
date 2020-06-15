-- Write an SQL query to get the names of products with greater than or equal to
-- 100 units ordered in February 2020 and their amount.
-- Return result table in any order.

SELECT p.product_name, SUM(o.unit) AS unit
FROM Orders o LEFT JOIN Products p
ON (o.product_id = p.product_id)
WHERE EXTRACT(MONTH FROM order_date) = '2' -- WHERE LEFT(order_date, 7) = '2020-02'
GROUP BY p.product_name
HAVING unit >= 100
