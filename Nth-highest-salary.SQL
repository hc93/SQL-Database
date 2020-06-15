-- CREATE FUNCTION, OFFSET
-- Write a SQL query to get the nth highest salary from the Employee table.

-- Solution 1
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  SET N = N - 1;
  RETURN (
      SELECT DISTINCT Salary FROM Employee
      ORDER BY Salary DESC LIMIT 1 OFFSET N
  );
END


-- Solution 2
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      SELECT Salary FROM (
      SELECT DISTINCT Salary, DENSE_RANK() OVER(ORDER BY Salary DESC) AS rk
      FROM Employee ) t
      WHERE t.rk = N
  );
END
