## Write an SQL query that reports for every date within at most 90 days from today,
## the number of users that logged in for the first time on that date.
## Assume today is 2019-06-30.

SELECT login_date, COUNT(user_id) AS user_count FROM (
  SELECT user_id, MIN(activity_date) AS login_date
  FROM Traffic
  WHERE activity = 'login'
  GROUP BY user_id
) AS sub
WHERE DATEDIFF('2019-06-30', login_date) <= 90
GROUP BY login_date




SELECT login_date, COUNT(user_id) AS user_count FROM (
  SELECT user_id, MIN(activity_date) AS login_date
  FROM Traffic
  WHERE activity = 'login'
  GROUP BY user_id
  HAVING login_date >= ADDDATE('2019-06-30', INTERVAL -90 DAY)
) AS t
GROUP BY login_date
