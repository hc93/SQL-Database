SELECT e1.Name AS Employee FROM Employee e1
WHERE e1.Salary > (SELECT Salary FROM Employee WHERE Id = e1.ManagerId);


SELECT e1.Name AS Employee
FROM Employee e1 JOIN Employee e2 ON (e1.ManagerId = e2.ID)
WHERE e1.Salary > e2.Salary;
