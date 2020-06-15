-- Write a SQL query to find employees who earn the top three salaries in each of the department.

-- Observation:
-- use DISTINCT: Salaries are not distinct for all employees
-- How to display if department has fewer than 3 distinct salaries?


-- Solution 1: using subquery
-- What do the top 3 paid employees in each department have in common?
-- They have the same departmentID; they have fewer than 3 people who get paid higher salaries.

SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee e JOIN Department d
ON (e.DepartmentId = d.Id)
WHERE ( SELECT COUNT(DISTINCT e2.Salary)
        FROM Employee e2
        WHERE e2.Salary > e.Salary AND e2.DepartmentId = e.DepartmentId ) < 3


-- Solution 2: window function
-- Recap: RANK() vs. DENSE_RANK()
-- DENSE_RANK(): No ranks are skipped if there are ranks with multiple items

SELECT d.Name AS Department, t.Name AS Employee, t.Salary
FROM
( SELECT Id, Name, Salary, DepartmentId,
         DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS Salary_rank
  FROM Employee) AS t
JOIN Department d
ON (t.DepartmentId = d.Id)
WHERE t.Salary_rank <= 3
