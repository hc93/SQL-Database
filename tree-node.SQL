## Write a query to print the node id and the type of the node.
## Sort your output by the node id.

SELECT id, (CASE WHEN p_id is NULL THEN 'Root'
            WHEN id IN (SELECT p_id FROM tree) THEN 'Inner'
            ELSE 'Leaf'
            END) AS Type
FROM tree
ORDER BY id;



SELECT id, IF(ISNULL(p_id), 'Root', IF(id IN (SELECT p_id FROM tree), 'Inner', 'Leaf'))
AS Type
FROM tree ORDER BY id;
