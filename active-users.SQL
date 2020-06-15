-- Accounts:
-- id | name

-- Logins:
-- id | login_date

-- A user may log in multiple times in the day.
-- Write an SQL query to find the id and the name of active users.
-- Active users are those who logged in to their accounts for 5 or more consecutive days.
-- Return the result table ordered by the id.

-- Follow up:
-- Can you write a general solution if the active users are those who logged in to their accounts
-- for n or more consecutive days?


-- Solution 1 - Window function
SELECT DISTINCT sub.id, a.name
FROM (
  SELECT id, login_date,
         LEAD(login_date, 4) OVER(PARTITION BY id ORDER BY login_date) AS lead_date
  FROM ( SELECT DISTINCT id, login_date FROM Logins ) t
) sub
JOIN Accounts a ON (sub.id = a.id)
WHERE DATEDIFF(sub.lead_date, sub.login_date) = 4
ORDER BY sub.id


-- Solution 2 - JOIN
SELECT DISTINCT x.id, (SELECT name FROM Accounts a WHERE a.id = x.id) AS name
FROM Logins x, Logins y
WHERE x.id = y.id AND DATEDIFF(y.login_date, x.login_date) BETWEEN 1 AND 4
GROUP BY x.id, x.login_date
HAVING COUNT(DISTINCT y.login_date) = 4
ORDER BY x.id


-- Solution 3 - Subquery + JOIN
SELECT * FROM Accounts
WHERE id IN (
  SELECT DISTINCT x.id FROM Logins x
  JOIN Logins y ON x.id = y.id AND DATEDIFF(y.login_date, x.login_date) BETWEEN 1 AND 4
  GROUP BY x.id, x.login_date
  HAVING COUNT(DISTINCT y.login_date) = 4
)
ORDER BY id
