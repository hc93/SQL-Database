-- Write a query to find the overall acceptance rate of requests rounded to 2 decimals,
-- which is the number of acceptance divide the number of requests.

-- Note: count the total accepted requests / the number of requests.
-- Be careful with duplicated requests or acceptances.
-- If there is no requests at all, you should return 0.00 as the acceptance rate.
-- Round to 2 decimals in the end.

SELECT ROUND(IFNULL(
   (SELECT COUNT(DISTINCT requester_id, accepter_id) FROM request_accepted)
   /
   (SELECT COUNT(DISTINCT sender_id, send_to_id) FROM friend_request), 0), 2)
AS accept_rate


-- Follow-up 1:
-- Can you write a query to return the accept rate but for every month?
-- build temp table
WITH t1 AS (
  SELECT COUNT(DISTINCT requester_id, accepter_id) AS accept_cnt, MONTH(accept_date) AS month FROM request_accepted
), t2 AS (
  SELECT COUNT(DISTINCT sender_id, send_to_id) AS req_cnt, MONTH(request_date) AS month FROM friend_request
)
SELECT t1.month, IF(t2.req_cnt = 0, 0.00, ROUND(t1.accept_cnt / t2.req_cnt, 2)) AS accept_rate
FROM t1
JOIN t2 ON (t1.month = t2.month)
GROUP BY t1.month


-- Follow-up 2:
-- How about the cumulative accept rate for every day?
