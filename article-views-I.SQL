## Write an SQL query to find all the authors that viewed at least one of their own articles,
## sorted in ascending order by their id.

SELECT DISTINCT viewer_id AS id FROM Views
WHERE viewer_id = author_id
ORDER BY viewer_id;
