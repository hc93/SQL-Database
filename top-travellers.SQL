-- Users: id | name
-- Rides: id | user_id | distance

-- Write an SQL query to report the distance travelled by each user.

SELECT u.name, IFNULL(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r ON (u.id = r.user_id)
GROUP BY u.name
ORDER BY travelled_distance DESC, u.name ASC
