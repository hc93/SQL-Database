## Write a SQL query to find the highest grade with its corresponding course
## for each student. In case of a tie, you should find the course with the smallest
## course_id. The output must be sorted by increasing student_id.

SELECT student_id, MIN(course_id) AS course_id, grade
FROM Enrollments
WHERE (student_id, grade) IN (
  SELECT student_id, MAX(grade) AS max_grade
  FROM Enrollments
  GROUP BY student_id
)
GROUP BY student_id, grade
ORDER BY student_id
