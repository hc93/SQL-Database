-- Write a query to print the respective department name and number of students
-- majoring in each department for all departments in the department table
-- (even ones with no current students).

-- Sort your results by descending number of students
-- If two or more departments have the same number of students,
-- then sort those departments alphabetically by department name.

SELECT d.dept_name, IFNULL(COUNT(DISTINCT s.student_id), 0) AS student_number
FROM department d LEFT JOIN student s
ON (d.dept_id = s.dept_id)
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name
