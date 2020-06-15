-- NPV (net present value):
-- id | year | npv

-- Queries:
-- id | year

-- Write an SQL query to find the npv of all each query of queries table.
-- Return the result table in any order.

SELECT q.id, q.year, COALESCE(n.npv, 0) AS npv
FROM Queries q
LEFT JOIN NPV n
ON (q.id = n.id AND q.year = n.year)
