## Write a query to return the list of customers NOT referred by the person with id '2'.

SELECT c.name FROM customer c
WHERE c.id NOT IN
  (SELECT id FROM customer
   WHERE referee_id = '2')
