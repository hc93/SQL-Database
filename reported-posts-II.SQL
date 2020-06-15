-- Write an SQL query to find the average for daily percentage of posts
-- that got removed after being reported as spam, rounded to 2 decimal places.


-- solution 1: LEFT JOIN + CASE WHEN (2 subtables)
SELECT ROUND(AVG(sub.removal_rate) * 100, 2) AS average_daily_percent
FROM (
  SELECT t.action_date,
         (COUNT(DISTINCT CASE WHEN remove_date IS NOT NULL THEN t.post_id ELSE NULL END)) / COUNT(DISTINCT t.post_id) AS removal_rate
  FROM (
    SELECT a.post_id, a.action_date, r.remove_date
    FROM Actions a LEFT JOIN Removals r
    ON (a.post_id = r.post_id)
    WHERE a.extra = 'spam'
  ) t
  GROUP BY t.action_date
) sub


-- solution 2: LEFT JOIN + CASE WHEN (1 subtable)
SELECT ROUND(AVG(t.num_removed / t.num_spams) * 100, 2) AS average_daily_percent
FROM (
  SELECT action_date, COUNT(DISTINCT a.post_id) AS num_spams,
         COUNT(DISTINCT CASE WHEN remove_date IS NOT NULL THEN a.post_id ELSE NULL END) AS num_removed
  FROM Actions a LEFT JOIN Removals r
  ON (a.post_id = r.post_id)
  WHERE extra = 'spam'
  GROUP BY action_date
  HAVING num_spams > 0
) t
