-- Select all employee's name and bonus whose bonus is < 1000.


SELECT name, bonus FROM Employee e
LEFT JOIN Bonus b ON (e.empId = b.empId)
WHERE bonus < 1000 OR bonus IS NULL
