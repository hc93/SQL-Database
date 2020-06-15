-- Write a SQL query to find the cancellation rate of requests made by unbanned users
-- (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013.

SELECT Request_at AS Day,
       ROUND(SUM(CASE WHEN Status != 'completed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE Request_at BETWEEN '2013-10-01' AND '2013-10-03'
      AND Client_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
      AND Driver_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
GROUP BY Request_at
ORDER BY Request_at
