-- Sessions:
-- session_id | duration

-- Key: not every category of duration has sessions

-- Solution 1:
-- use RIGHT JOIN to ensure all the categories are present
-- then GROUP BY and use IFNULL to fill in 0

SELECT t2.bin, IFNULL(COUNT(t1.session_id), 0) AS total
FROM (
  SELECT session_id,
         CASE WHEN duration/60 < 5 THEN '[0-5>'
              WHEN duration/60 >= 5 AND duration/60 < 10 THEN '[5-10>'
              WHEN duration/60 >= 10 AND duration/60 < 15 THEN '[10-15>'
              ELSE '15 or more' END AS bin
  FROM Sessions
) t1
RIGHT JOIN (
  SELECT '[0-5>' AS bin
  UNION ALL
  SELECT '[5-10>' AS bin
  UNION ALL
  SELECT '[10-15>' AS bin
  UNION ALL
  SELECT '15 or more' AS bin
) t2 ON (t1.bin = t2.bin)
GROUP BY t2.bin


-- Solution 2:
-- create a temp table
-- select one category at a time and use UNION ALL to combine all the subtables
-- SUM(CASE WHEN...) to create the column total

WITH temp AS (
  SELECT duration/60 AS mins
  FROM sessions
)

SELECT '[0-5>' AS bin,
       SUM(CASE WHEN mins < 5 THEN 1 ELSE 0 END) AS total
FROM temp
UNION ALL
SELECT '[5-10>' AS bin,
       SUM(CASE WHEN mins >= 5 AND mins < 10 THEN 1 ELSE 0 END) AS total
FROM temp
UNION ALL
SELECT '[10-15>' AS bin,
       SUM(CASE WHEN mins >= 10 AND mins < 15 THEN 1 ELSE 0 END) AS total
FROM temp
UNION ALL
SELECT '15 or more' AS bin,
       SUM(CASE WHEN mins >= 15 THEN 1 ELSE 0 END) AS total
FROM temp
