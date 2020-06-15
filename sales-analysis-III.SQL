## Write an SQL query that reports the products that were **only** sold in spring 2019.
## That is, between 2019-01-01 and 2019-03-31 inclusive.


SELECT s.product_id, MAX(p.product_name) AS product_name
FROM Sales s JOIN Product p ON (s.product_id = p.product_id)
GROUP BY s.product_id
HAVING (MAX(s.sale_date) <= '2019-03-31') AND (MIN(s.sale_date) >= '2019-01-01');
