-- Write an SQL query to generate a report of period_state for each continuous interval of days
-- in the period from 2019-01-01 to 2019-12-31.

SELECT period_state, MIN(date) AS start_date, MAX(date) AS end_date
FROM (
    SELECT t.*,
           ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY date) AS seq
    FROM
    ( SELECT fail_date AS date, 'failed' AS period_state
      FROM Failed
      UNION ALL
      SELECT success_date AS date, 'succeeded' AS period_state
      FROM Succeeded ) t
    WHERE date BETWEEN '2019-01-01' AND '2019-12-31'
 ) tmp
GROUP BY DATEADD(day, -seq, date), period_state   -- punchline
ORDER BY start_date
