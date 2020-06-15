## Write a SQL query to find all dates' Ids with higher temperature compared to
## its previous (yesterday's) dates.


SELECT w2.Id
FROM Weather w1, Weather w2
WHERE w1.Temperature < w2.Temperature AND DATEDIFF(w2.RecordDate, w1.RecordDate) = 1
