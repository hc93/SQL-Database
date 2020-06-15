-- Write an SQL query that reports all the projects that have the most employees.

SELECT project_id FROM Project
GROUP BY project_id
HAVING COUNT(employee_id) = (
  SELECT COUNT(employee_id) FROM Project
  GROUP BY project_id
  ORDER BY COUNT(employee_id) DESC
  LIMIT 1
)
