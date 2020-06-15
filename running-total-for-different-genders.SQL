-- Write an SQL query to find the total score for each gender at each day.
-- Order the result table by gender and day.

-- Window function
SELECT gender, day,
       SUM(score_points) OVER(PARTITION BY gender ORDER BY day) AS total
FROM Scores
ORDER BY gender, day

-- Self join
SELECT s1.gender, s1.day,
       SUM(s2.score_points) AS total
FROM Scores s1 JOIN Scores s2
ON (s1.gender = s2.gender AND s2.day <= s1.day)
GROUP BY s1.gender, s1.day
ORDER BY s1.gender, s1.day
