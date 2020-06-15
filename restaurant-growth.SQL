-- You are the restaurant owner and you want to analyze a possible expansion
-- (there will be at least one customer every day).
-- Write an SQL query to compute moving average of how much customer paid
-- in a 7 days window (current day + 6 days before).

-- average_amount should be rounded to 2 decimal places.
-- All dates are in the format ('YYYY-MM-DD').

-- solution 1
SELECT a.visited_on AS visited_on,
       SUM(b.day_sum) AS amount,
       ROUND(AVG(b.day_sum), 2) AS average_amount
FROM
  ( SELECT visited_on, SUM(amount) AS day_sum
    FROM Customer
    GROUP BY visited_on ) a
LEFT JOIN
  ( SELECT visited_on, SUM(amount) AS day_sum
    FROM Customer
    GROUP BY visited_on ) b
ON DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6
GROUP BY a.visited_on
HAVING COUNT(b.visited_on) = 7

-- solution 2
SELECT a.visited_on AS visited_on, SUM(b.day_sum) AS amount,
       ROUND(AVG(b.day_sum), 2) AS average_amount
FROM
  (SELECT visited_on, SUM(amount) AS day_sum FROM Customer GROUP BY visited_on ) a,
  (SELECT visited_on, SUM(amount) AS day_sum FROM Customer GROUP BY visited_on ) b
WHERE DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6
GROUP BY a.visited_on
HAVING COUNT(b.visited_on) = 7
