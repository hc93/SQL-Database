-- Please write a query to display the records which have 3 or more
-- consecutive rows and the amount of people more than 100(inclusive).

-- Solution 1: Window Function
SELECT id, visit_date, people
FROM
( SELECT *, LAG(people, 2) OVER (ORDER BY id) AS prev2,
            LAG(people, 1) OVER (ORDER BY id) AS prev1,
            LEAD(people, 1) OVER (ORDER BY id) AS next1,
            LEAD(people, 2) OVER (ORDER BY id) AS next2
  FROM stadium ) t
WHERE people >= 100 AND (
  (prev2 >= 100 AND prev1 >= 100) OR
  (prev1 >= 100 AND next1 >= 100) OR
  (next1 >= 100 AND next2 >= 100)
)
ORDER BY id

-- Solution 2: JOIN

-- JOIN by id is more efficient than JOIN by visit_date.
-- Scanning three-day consecutive window: a valid row can
-- either be positioned at the beginning, middle, or end
-- of the window.

-- SELF JOIN: Cartesian product
-- need to use DISTINCT to de-duplicate

SELECT DISTINCT s1.*
FROM stadium s1, stadium s2, stadium s3
WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
AND ((s1.id = s2.id - 1 AND s1.id = s3.id - 2)
  OR (s1.id = s2.id + 1 AND s1.id = s3.id - 1)
  OR (s1.id = s2.id + 2 AND s1.id = s3.id + 1))
ORDER BY s1.id

-- Pre-filtering before JOIN
SELECT DISTINCT s1.*
FROM (SELECT * FROM stadium WHERE people >= 100) AS s1,
     (SELECT * FROM stadium WHERE people >= 100) AS s2,
     (SELECT * FROM stadium WHERE people >= 100) AS s3
WHERE ((s1.id = s2.id - 1 AND s1.id = s3.id - 2)
    OR (s1.id = s2.id + 1 AND s1.id = s3.id - 1)
    OR (s1.id = s2.id + 2 AND s1.id = s3.id + 1))
ORDER BY s1.id

-- LEFT JOIN
SELECT DISTINCT s1.*
FROM stadium AS s1
LEFT JOIN stadium AS s2 ON s1.people >= 100 AND s2.people >= 100
LEFT JOIN stadium AS s3 ON s3.people >= 100
WHERE ((s1.id = s2.id - 1 AND s1.id = s3.id - 2)
    OR (s1.id = s2.id + 1 AND s1.id = s3.id - 1)
    OR (s1.id = s2.id + 2 AND s1.id = s3.id + 1))
ORDER BY s1.id
