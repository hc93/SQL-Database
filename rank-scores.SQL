# To determine the rank of a score: count the number of distinct scores that are >= to that score

SELECT S1.Score,
       (SELECT COUNT(DISTINCT Score) FROM Scores AS S2 WHERE S2.Score >= S1.Score) AS Rank
FROM Scores AS S1
ORDER BY Score DESC;
