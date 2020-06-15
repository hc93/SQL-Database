## Write an SQL query to find the percentage of immediate orders
## in the first orders of all customers, rounded to 2 decimal places.

## MySQL
SELECT
  ROUND(AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0
  END) * 100, 2) AS immediate_percentage
FROM
    ( SELECT customer_id, MIN(order_date) AS order_date, MIN(customer_pref_delivery_date) AS customer_pref_delivery_date
      FROM Delivery
      GROUP BY customer_id ) AS t


## MySQL
SELECT
  ROUND(AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0
  END) * 100, 2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)


## window function (MS SQL Server), too slow
SELECT
  ROUND(COUNT(CASE WHEN DATEDIFF(DAY, order_date, customer_pref_delivery_date) = 0 THEN customer_id ELSE NULL
  END) * 100.00 / COUNT(customer_id), 2) AS immediate_percentage
FROM (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS ord
  FROM Delivery) AS t
WHERE ord = 1


SELECT
  ROUND(100.00 * SUM(CASE WHEN DATEDIFF(DAY, order_date, customer_pref_delivery_date) = 0 THEN 1 ELSE 0
  END) / COUNT(customer_id), 2) AS immediate_percentage
FROM (
  SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS ord
  FROM Delivery) AS t
WHERE ord = 1
