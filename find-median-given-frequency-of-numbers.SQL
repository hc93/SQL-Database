-- Solution 1
SELECT AVG(n.Number) AS median
FROM Numbers n
WHERE n.Frequency >= ABS(
   (SELECT SUM(Frequency) FROM Numbers WHERE Number <= n.Number) -
   (SELECT SUM(Frequency) FROM Numbers WHERE Number >= n.Number)
)

-- Solution 2
SELECT AVG(Number) AS median
FROM (
    SELECT *, @cum_freq:= @cum_freq+Frequency AS cum_freq
    FROM Numbers, (SELECT @cum_freq:=0) t
    ORDER BY Number
) cum
WHERE ((SELECT ROUND(SUM(Frequency)/2, 0) FROM Numbers) BETWEEN cum_freq-Frequency+1 AND cum_freq)
   OR ((SELECT ROUND(SUM(Frequency)/2+0.5, 0) FROM Numbers) BETWEEN cum_freq-Frequency+1 AND cum_freq)
