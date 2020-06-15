-- Please write a sql query to get the amount of each follower’s follower if he/she has one.

-- Subquery
SELECT DISTINCT f.follower, t.num
FROM follow f, (SELECT followee, COUNT(DISTINCT follower) AS num FROM follow
                GROUP BY followee) AS t
WHERE f.follower = t.followee
ORDER BY f.follower

-- SELF JOIN
SELECT f1.follower AS follower, COUNT(DISTINCT f2.follower) AS num
FROM follow f1 JOIN follow f2 ON (f1.follower = f2.followee)
GROUP BY f1.follower
ORDER BY f1.follower

-- Subquery using IN (fastest)
SELECT f.followee AS follower, COUNT(DISTINCT f.follower) AS num
FROM follow f
WHERE f.followee IN (SELECT DISTINCT follower FROM follow)
GROUP BY f.followee
ORDER BY f.followee
