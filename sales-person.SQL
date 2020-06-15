## Output all the names in the table salesperson, who didn’t have sales to company 'RED'.

(solution 1)

SELECT s.name FROM salesperson s
WHERE s.sales_id NOT IN (
    SELECT o.sales_id FROM orders o
    WHERE o.com_id = (SELECT com_id FROM company WHERE name = 'RED')
   )



(solution 2 -- JOIN)

SELECT s.name FROM salesperson s
WHERE s.sales_id NOT IN (
    SELECT o.sales_id FROM orders o
    LEFT JOIN company c ON (o.com_id = c.com_id)
    WHERE c.name = 'RED'
  )
