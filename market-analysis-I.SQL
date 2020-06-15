## Write an SQL query to find for each user, the join date and the number of orders
## they made as a buyer in 2019.

SELECT u.user_id AS buyer_id, u.join_date, COALESCE(t.orders_in_2019, 0) AS orders_in_2019
FROM Users u
LEFT JOIN
  (
    SELECT buyer_id, COUNT(order_id) AS orders_in_2019
    FROM Orders
    WHERE order_date BETWEEN '2019-01-01' AND '2019-12-31'
    GROUP BY buyer_id
  ) t ON (u.user_id = t.buyer_id)




SELECT u.user_id AS buyer_id, u.join_date, COALESCE(COUNT(o.order_id), 0) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON (u.user_id = o.buyer_id) AND o.order_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY u.user_id
