## Write an SQL query to find for each month and country, the number of transactions
## and their total amount, the number of approved transactions and their total amount.

SELECT LEFT(trans_date, 7) AS month, country, COUNT(id) AS trans_count,
       SUM(IF(state = 'approved', 1, 0)) AS approved_count, SUM(amount) AS trans_total_amount,
       SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY month, country



SELECT LEFT(trans_date, 7) AS month, country, COUNT(id) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count, SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country
