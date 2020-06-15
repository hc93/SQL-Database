-- Student:
-- student_id | student_name

-- Exam:
-- exam_id | student_id | score

-- A "quiet" student is the one who took at least one exam
-- and didn't score neither the high score nor the low score.

-- Write an SQL query to report the students (student_id, student_name)
-- being "quiet" in ALL exams.

-- Don't return the student who has never taken any exam.
-- Return the result table ordered by student_id.

-- Solution 1
WITH tmp AS (
  SELECT student_id,
         DENSE_RANK() OVER (PARTITION BY exam_id ORDER BY score) AS asc_rank,
         DENSE_RANK() OVER (PARTITION BY exam_id ORDER BY score DESC) AS desc_rank
  FROM Exam
)

SELECT student_id, student_name
FROM Student
-- took at least one exam
WHERE student_id IN (SELECT DISTINCT student_id FROM Exam)
-- didn't score neither the highest nor the lowest.
AND student_id NOT IN (SELECT student_id FROM tmp WHERE asc_rank = 1 OR desc_rank = 1)
ORDER BY student_id


-- Solution 2
WITH tmp1 AS (
  SELECT exam_id, MAX(score) AS max_score, MIN(score) AS min_score
  FROM Exam
  GROUP BY exam_id
), tmp2 AS (
  SELECT e.student_id, COUNT(e.exam_id) AS total_exams,
         SUM(CASE WHEN e.score > tmp1.min_score AND e.score < tmp1.max_score THEN 1 ELSE 0 END) AS quiet_exams
  FROM Exam e
  JOIN tmp1 ON (e.exam_id = tmp1.exam_id)
  GROUP BY e.student_id
)

SELECT s.student_id, s.student_name
FROM Student s
JOIN tmp2 ON (s.student_id = tmp2.student_id)
WHERE tmp2.total_exams = tmp2.quiet_exams
ORDER BY s.student_id
