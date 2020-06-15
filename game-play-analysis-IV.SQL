-- Write an SQL query that reports the fraction of players that logged in
-- again on the day after the day they first logged in, rounded to 2 decimal places.

-- Solution 1
SELECT ROUND((COUNT(t.player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity)), 2) AS fraction
FROM
    ( SELECT player_id, event_date FROM Activity
      WHERE (player_id, event_date) IN
        (
          SELECT player_id, ADDDATE(MIN(event_date), INTERVAL 1 DAY) AS target_date
          FROM Activity
          GROUP BY player_id
        )
    ) AS t


-- Solution 1 using temp tables (my solution)
WITH first_login AS (
  SELECT player_id, MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id
), second_login AS (
  SELECT a.player_id, a.event_date
  FROM Activity a
  JOIN first_login f
  ON (a.player_id = f.player_id AND a.event_date = ADDDATE(f.first_login, INTERVAL 1 DAY))
)

SELECT ROUND(
  (SELECT COUNT(DISTINCT player_id) FROM second_login) /
  (SELECT COUNT(DISTINCT player_id) FROM Activity), 2)
AS fraction


-- Solution 2: Left Join
SELECT ROUND(COUNT(t2.player_id) / COUNT(t1.player_id), 2) AS fraction
FROM
( SELECT player_id, MIN(event_date) AS first_login
  FROM Activity
  GROUP BY player_id ) t1
LEFT JOIN Activity t2
ON (t1.player_id = t2.player_id AND t1.first_login + 1 = t2.event_date)
