-- Write an SQL query to find the number of times each student attended each exam.
-- Order the result table by student_id and subject_name.
-- The result table should contain all students and all subjects.

-- CROSS JOIN 

SELECT st.student_id, st.student_name, sub.subject_name, IFNULL(COUNT(e.subject_name), 0) AS attended_exams
FROM Students st CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON (st.student_id = e.student_id AND sub.subject_name = e.subject_name)
GROUP BY student_id, subject_name
ORDER BY student_id, subject_name
