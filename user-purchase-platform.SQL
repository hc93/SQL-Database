-- Write an SQL query to find the total number of users and the total amount spent
-- using mobile only, desktop only and both mobile and desktop together for each date.

SELECT t1.spend_date, t1.platform,
       IFNULL(SUM(amount), 0) AS total_amount,
       COUNT(user_id) AS total_users
FROM (
    SELECT DISTINCT(spend_date), 'mobile' AS platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'desktop' AS platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'both' AS platform FROM Spending
) t1
LEFT JOIN (
    SELECT spend_date, user_id,
           IF(mobile_amount > 0, IF(desktop_amount > 0, 'both', 'mobile'), 'desktop') AS platform,
           (mobile_amount + desktop_amount) AS amount
    FROM (
        SELECT spend_date, user_id,
               SUM(CASE WHEN platform = 'mobile' THEN amount ELSE 0 END) AS mobile_amount,
               SUM(CASE WHEN platform = 'desktop' THEN amount ELSE 0 END) AS desktop_amount
        FROM Spending
        GROUP BY spend_date, user_id
      ) sub
) t2 ON (t1.spend_date = t2.spend_date AND t1.platform = t2.platform)
GROUP BY t1.spend_date, t1.platform
