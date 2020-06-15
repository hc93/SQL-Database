## Write an SQL query to find for each month and country,
## the number of approved transactions and their total amount,
## the number of chargebacks and their total amount.



SELECT month, country, SUM(IF(state = 'approved', 1, 0)) AS approved_count,
       SUM(IF(state = 'approved', amount, 0)) AS approved_amount,
       SUM(IF(state = 'chargeback', 1, 0)) AS chargeback_count,
       SUM(IF(state = 'chargeback', amount, 0)) AS chargeback_amount
FROM
    ( SELECT LEFT(c.trans_date, 7) AS month, country, 'chargeback' AS state, amount
      FROM Chargebacks c
      JOIN Transactions t ON (c.trans_id = t.id)
     UNION ALL
      SELECT LEFT(trans_date, 7) AS month, country, state, amount
      FROM Transactions
      WHERE state = 'approved'
    ) AS sub
GROUP BY month, country
