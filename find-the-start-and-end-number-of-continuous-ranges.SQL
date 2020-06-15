-- Some IDs have been removed from Logs.
-- Write an SQL query to find the start and end number of continuous ranges in table Logs.
-- Order the result table by start_id.


SELECT MIN(log_id) AS start_id, MAX(log_id) AS end_id
FROM (
  SELECT log_id, (log_id - ROW_NUMBER() OVER(ORDER BY log_id)) AS group_id
  FROM Logs
) t
GROUP BY group_id
ORDER BY start_id
