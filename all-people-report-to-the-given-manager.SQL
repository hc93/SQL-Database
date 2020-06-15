-- Write an SQL query to find employee_id of all employees that directly or
-- indirectly report their work to the head of the company.

-- The head of the company is the employee with employee_id = 1.
-- The indirect relation between managers will not exceed 3 managers as the company is small.

SELECT employee_id FROM Employees
WHERE employee_id != 1 AND manager_id = 1
UNION
SELECT employee_id FROM Employees
WHERE manager_id IN (
    SELECT employee_id FROM Employees
    WHERE employee_id != 1 AND manager_id = 1 )
UNION
SELECT employee_id FROM Employees
WHERE manager_id IN (
    SELECT employee_id FROM Employees
    WHERE manager_id IN (
        SELECT employee_id FROM Employees
        WHERE employee_id != 1 AND manager_id = 1 )
)
ORDER BY employee_id
