## Write a SQL query to find employees who have the highest salary in each of the departments.

SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee AS e, Department AS d
WHERE e.DepartmentID = d.ID AND
      e.Salary = (SELECT MAX(Salary) FROM Employee WHERE Employee.DepartmentID = e.DepartmentID);


SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee AS e JOIN Department AS d ON (e.DepartmentID = d.ID)
WHERE e.Salary = (SELECT MAX(Salary) FROM Employee WHERE Employee.DepartmentID = e.DepartmentID);
