## Write an SQL query to find the percentage of immediate orders
## in the table, rounded to 2 decimal places.


SELECT
  ROUND(100 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2)
  AS immediate_percentage
FROM Delivery
