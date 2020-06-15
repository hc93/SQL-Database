## Write a SQL query to find the biggest number, which only appears once.
## If there is no such number, just output null.

SELECT MAX(t.num) AS num
FROM
  ( SELECT num FROM my_numbers
    GROUP BY num
    HAVING COUNT(*) = 1 ) t


SELECT IFNULL(
  (SELECT num FROM my_numbers
   GROUP BY num
   HAVING COUNT(*) = 1
   ORDER BY num DESC LIMIT 1)
, NULL) AS num


SELECT MAX(num) AS num
FROM my_numbers
WHERE num IN (
  SELECT num FROM my_numbers
  GROUP BY num
  HAVING COUNT(*) = 1
)
