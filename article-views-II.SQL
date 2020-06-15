## Write an SQL query to find all the people who viewed more than one article
## on the same date, sorted in ascending order by their id.

SELECT DISTINCT viewer_id AS id
FROM (
  SELECT viewer_id, view_date, COUNT(DISTINCT article_id) AS num_article
  FROM Views
  GROUP BY viewer_id, view_date
) AS t
WHERE num_article > 1
ORDER BY viewer_id


# (better solution)

SELECT DISTINCT viewer_id AS id
FROM Views
GROUP BY viewer_id, view_date
HAVING COUNT(DISTINCT article_id) > 1
ORDER BY viewer_id
