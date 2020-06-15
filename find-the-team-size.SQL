-- Write an SQL query to find the team size of each of the employees.

SELECT employee_id, team_size
FROM Employee AS e
LEFT JOIN (
    SELECT team_id, COUNT(DISTINCT employee_id) AS team_size
    FROM Employee
    GROUP BY team_id
) AS t
ON e.team_id = t.team_id
