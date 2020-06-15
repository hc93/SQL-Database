-- Given the Employee table, write a SQL query that finds out
-- managers with at least 5 direct reports.

SELECT Name FROM Employee
WHERE Id IN
    ( SELECT ManagerId FROM Employee
      --WHERE ManagerId IS NOT NULL
      GROUP BY ManagerId
      HAVING COUNT(ManagerId) >= 5 )


-- using JOIN, faster
SELECT Name FROM Employee e1
JOIN
   (
     SELECT ManagerId FROM Employee
     GROUP BY ManagerId
     HAVING COUNT(ManagerId) >= 5
   ) t
ON (e1.Id = t.ManagerId)
