-- Write a SQL to get the cumulative sum of an employee's salary
-- over a period of 3 months but exclude the most recent month.
-- The result should be displayed by 'Id' ascending, and then by 'Month' descending.


-- LEFT JOIN & handle NULL
SELECT e.Id, e.Month,
       IFNULL(e.Salary, 0) + IFNULL(e1.Salary, 0) + IFNULL(e2.Salary, 0) AS Salary
FROM Employee e
LEFT JOIN Employee e1 ON (e.Id = e1.Id AND e.Month = e1.Month + 1)
LEFT JOIN Employee e2 ON (e.Id = e2.Id AND e.Month = e2.Month + 2)
-- exclude the most recent month
WHERE (e.Id, e.Month) NOT IN (
    SELECT Id, MAX(Month) FROM Employee GROUP BY Id
)
ORDER BY e.ID ASC, e.Month DESC



-- Window function
SELECT *
FROM (
    SELECT Id,
           LAG(Month, 1) OVER(PARTITION BY Id ORDER BY Month ASC) AS Month,
           ISNULL(LAG(Salary, 1) OVER(PARTITION BY Id ORDER BY Month ASC), 0) +
           ISNULL(LAG(Salary, 2) OVER(PARTITION BY Id ORDER BY Month ASC), 0) +
           ISNULL(LAG(Salary, 3) OVER(PARTITION BY Id ORDER BY Month ASC), 0) AS Salary
    FROM Employee
) t
WHERE Month IS NOT NULL
ORDER BY Id ASC, Month DESC
