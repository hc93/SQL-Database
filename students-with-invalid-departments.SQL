-- Departments:
-- id, name

-- Students:
-- id, name, department_id

-- Write an SQL query to find the id and the name of all students
-- who are enrolled in departments that no longer exists.

SELECT id, name
FROM Students
WHERE department_id NOT IN (
  SELECT id FROM Departments
)
