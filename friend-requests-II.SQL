-- -- -- Review -- -- --

-- UNION combines the result set of two or more SELECT statements (only distinct values)
-- UNION ALL combines the result set of two or more SELECT statements (allows duplicate values)

-- Write a query to find the people who has most friends and
-- the most friends number under the following rules:

-- It is guaranteed there is only 1 person having the most friends.
-- The friend request could only be accepted once, which mean
-- there is no multiple records with the same requester_id and accepter_id value.


-- leetcode solution (WRONG!)
SELECT t.id, COUNT(t.id) AS num FROM
  ( SELECT requester_id AS id FROM request_accepted
    UNION ALL
    SELECT accepter_id AS id FROM request_accepted
  ) AS t
GROUP BY t.id
ORDER BY num DESC LIMIT 1
-- The answer is double counting if I have person 1 sending request to person 2,
-- and person 2 sending request to person 1.


-- Solution
SELECT t.id1 AS id, COUNT(t.id2) AS num
FROM
  ( SELECT requester_id AS id1, accepter_id AS id2 FROM request_accepted
    UNION
    SELECT accepter_id AS id1, requester_id AS id2 FROM request_accepted
  ) t
GROUP BY t.id1
ORDER BY num DESC
LIMIT 1
