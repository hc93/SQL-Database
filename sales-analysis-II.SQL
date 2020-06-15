## Write an SQL query that reports the buyers who have bought S8 but not iPhone.
## Note that S8 and iPhone are products present in the Product table.

(solution 1)

SELECT DISTINCT s.buyer_id
FROM Sales s LEFT JOIN Product p ON (s.product_id = p.product_id)
WHERE p.product_name = 'S8' AND s.buyer_id NOT IN
  (
    SELECT DISTINCT s1.buyer_id FROM Sales s1
    LEFT JOIN Product p1 ON (s1.product_id = p1.product_id)
    WHERE p1.product_name = 'iPhone'
  );


(solution 2)

SELECT DISTINCT s.buyer_id
FROM Sales s LEFT JOIN Product p ON (s.product_id = p.product_id)
GROUP BY s.buyer_id
HAVING (SUM(CASE WHEN p.product_name = 'S8' then 1 else 0 END) >= 1) AND
       (SUM(CASE WHEN p.product_name = 'iPhone' then 1 else 0 END) = 0); 
