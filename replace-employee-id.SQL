-- Write an SQL query to show the unique ID of each user.
-- If a user doesn't have a unique ID replace just show null.
-- Return the result table in any order.

SELECT u.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
ON (e.id = u.id)
