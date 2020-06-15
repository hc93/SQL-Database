-- We define the install date of a player to be the first login day of that player.
-- Write an SQL query that reports for each install date,
-- the number of players that installed the game on that day and the day 1 retention.

-- Construct the temp table first, then use LEFT JOIN and SUM(CASE WHEN...) to count non-null values.


SELECT t1.install_dt, COUNT(DISTINCT t1.player_id) AS installs,
      ROUND(SUM(CASE WHEN a.event_date IS NOT NULL THEN 1 ELSE 0 END)/COUNT(DISTINCT t1.player_id), 2)
      AS Day1_retention
FROM
( SELECT player_id, MIN(event_date) AS install_dt
  FROM Activity
  GROUP BY player_id ) t1
LEFT JOIN Activity a
ON (t1.player_id = a.player_id AND t1.install_dt+1 = a.event_date)
GROUP BY t1.install_dt
