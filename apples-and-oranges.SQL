-- Sales:
-- sale_date | fruit | sold_num

-- Write an SQL query to report the difference between number of apples and oranges sold each day.
-- Return the result table ordered by sale_date in format ('YYYY-MM-DD').

-- JOIN (SELECT from multiple tables)
SELECT a.sale_date, (a.sold_num - o.sold_num) AS diff
FROM Sales a, Sales o
WHERE a.sale_date = o.sale_date AND a.fruit = 'apples' AND o.fruit = 'oranges'
GROUP BY a.sale_date


-- SUM(CASE WHEN...)
SELECT sale_date, (SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END) -
                   SUM(CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END)) AS diff
FROM Sales
GROUP BY sale_date
