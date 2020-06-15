-- Write an SQL query that reports the books that have sold fewer than
-- 10 copies in the last year, excluding books that have been available
-- for less than 1 month from today. Assume today is 2019-06-23.

-- Note:
-- Some unpopular books might never be sold, so they are not in the Orders table.
-- Therefore, we cannot simply select books sold fewer than 10 copies.

-- Solution 1
-- Use WHERE to filter qualified books first
-- Then use NOT IN to exclude the popular books sold last year

SELECT book_id, name FROM books
WHERE DATEDIFF('2019-06-23', available_from) > 30
AND book_id NOT IN
    (SELECT book_id FROM Orders
     WHERE DATEDIFF('2019-06-23', dispatch_date) <= 365
     GROUP BY book_id
     HAVING SUM(quantity) >= 10) -- subquery for popular books sold last year


-- Solution 2 - LEFT JOIN
SELECT b.book_id, b.name
FROM Books b LEFT JOIN Orders o
ON (b.book_id = o.book_id) AND DATEDIFF('2019-06-23', o.dispatch_date) <= 365
WHERE DATEDIFF('2019-06-23', b.available_from) > 30
GROUP BY b.book_id
HAVING SUM(IFNULL(o.quantity, 0)) < 10


-- Same logic using subquery
SELECT b.book_id, b.name
FROM Books b LEFT JOIN (SELECT * FROM Orders
     WHERE DATEDIFF('2019-06-23', dispatch_date) <= 365) AS o
ON (b.book_id = o.book_id)
WHERE DATEDIFF('2019-06-23', b.available_from) > 30
GROUP BY b.book_id
HAVING SUM(IFNULL(o.quantity, 0)) < 10
