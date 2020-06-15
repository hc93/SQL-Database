-- Visits table:
-- user_id | visit_date
-- primary key: (user_id, visit_date)

-- Transactions table:
-- user_id | transaction_date | amount
-- no primary key

-- Write an SQL query to find how many users visited the bank and didn't do any
-- transactions, how many visited the bank and did one transaction and so on.

-- The result table:
-- transactions_count | visits_count

-- transactions_count is the number of transactions done in one visit
-- visits_count is the corresponding number of users who did transactions_count in one visit to the bank
-- transactions_count should take all values from 0 to max(transactions_count) done by one or more users.

-- LEFT JOIN, recursive CTEs

WITH tmp AS (
  SELECT v.user_id, v.visit_date,
         COUNT(v.user_id) AS visits_count,
         SUM(CASE WHEN t.transaction_date IS NOT NULL THEN 1 ELSE 0 END) AS transactions_count
  FROM Visits v
  LEFT JOIN Transactions t
  ON (v.user_id = t.user_id AND v.visit_date = t.transaction_date)   -- per user per day
  GROUP BY v.user_id, v.visit_date
),

fill AS (
    SELECT 0 AS i, (SELECT MAX(transactions_count) FROM tmp) AS e
    UNION ALL
    SELECT i + 1, e FROM fill
    WHERE i < e
)

SELECT f.i AS transactions_count,
       ISNULL(COUNT(visits_count), 0) AS visits_count
FROM fill f
LEFT JOIN tmp ON (f.i = tmp.transactions_count)
GROUP BY f.i
ORDER BY transactions_count
