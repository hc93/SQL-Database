-- Write an SQL query to show the second most recent activity of each user.
-- If the user only has one activity, return that one.
-- A user can't perform more than one activity at the same time. Return the result table in any order.

-- UserActivity
-- username | activity | startDate | endDate

-- solution 1: window functions
SELECT username, activity, startDate, endDate
FROM (
    SELECT *, COUNT(activity) OVER (PARTITION BY username) AS cnt,
              RANK() OVER (PARTITION BY username ORDER BY endDate DESC) AS recency
    FROM UserActivity ) t
WHERE cnt = 1 OR recency = 2

-- solution 2: SELF JOIN + UNION (very fast)
SELECT *
FROM UserActivity
GROUP BY username
HAVING COUNT(activity) = 1

UNION

SELECT u1.*
FROM UserActivity u1, UserActivity u2
WHERE u1.username = u2.username AND u1.endDate < u2.endDate
GROUP BY u1.username, u1.endDate
HAVING COUNT(u2.endDate) = 1
