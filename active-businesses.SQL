## An active business is a business that has more than one event type with occurences
## greater than the average occurences of that event type among all businesses.

SELECT business_id
FROM
  ( SELECT event_type, AVG(occurences) AS avg_occurences
    FROM Events
    GROUP BY event_type ) AS t1
  JOIN Events e ON (t1.event_type = e.event_type)
WHERE e.occurences > t1.avg_occurences
GROUP BY business_id
HAVING COUNT(DISTINCT t1.event_type) > 1
