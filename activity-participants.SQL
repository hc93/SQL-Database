-- Friends:
-- id | name | activity
-- id is the primary key

-- Activities:
-- id | name
-- id is the primary key

-- Write an SQL query to find the names of all the activities with neither maximum,
-- nor minimum number of participants.
-- Return the result table in any order. Each activity in table Activities is performed
-- by any person in the table Friends.

-- Solution 1: temp table (MS SQL)
WITH activities AS (
  SELECT activity, COUNT(id) AS num_participants
  FROM Friends
  GROUP BY activity
)
SELECT activity FROM activities
WHERE num_participants != (SELECT MAX(num_participants) FROM activities)
      AND num_participants != (SELECT MIN(num_participants) FROM activities)


-- Solution 2: HAVING and UNION (MySQL)
SELECT activity FROM Friends
GROUP BY activity
HAVING COUNT(id) NOT IN
(
    SELECT MAX(num_participants) AS max_num
    FROM (
      SELECT activity, COUNT(id) AS num_participants
      FROM Friends
      GROUP BY activity
    ) t1
  UNION
    SELECT MIN(num_participants) AS min_num
    FROM (
      SELECT activity, COUNT(id) AS num_participants
      FROM Friends
      GROUP BY activity
    ) t2
)
