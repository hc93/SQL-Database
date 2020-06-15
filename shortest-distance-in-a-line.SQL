SELECT MIN(a.x - b.x) AS shortest
FROM point a, point b
WHERE a.x > b.x

(faster)
SELECT MIN(ABS(p1.x - p2.x)) AS shortest
FROM point p1 JOIN point p2 ON p1.x != p2.x
