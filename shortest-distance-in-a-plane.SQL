## (solution 1)
## Note: To put the MIN() inside of SQRT() will slightly improve the performance.

SELECT ROUND(SQRT(MIN(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM point_2d AS p1, point_2d AS p2
WHERE p1.x <> p2.x OR p1.y <> p2.y;


## (solution 2)
## Optimize to avoid reduplicate calculations

SELECT ROUND(SQRT(MIN(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))), 2) AS shortest
FROM point_2d AS p1, point_2d AS p2
WHERE (p1.x <= p2.x AND p1.y <> p2.y)
      OR (p1.x < p2.x AND p1.y = p2.y);
