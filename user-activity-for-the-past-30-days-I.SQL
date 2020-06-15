## Write an SQL query to find the daily active user count for a period of 30 days
## ending 2019-07-27 inclusively.
## A user was active on some day if he/she made at least one activity on that day.


SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN ADDDATE('2019-07-27', INTERVAL -29 DAY) AND '2019-07-27'
GROUP BY activity_date


SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE DATEDIFF('2019-07-27', activity_date) < 30
GROUP BY activity_date
