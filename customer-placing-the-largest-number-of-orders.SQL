-- Query the customer_number from the orders table for the customer who has placed
-- the largest number of orders.

-- It is guaranteed that exactly one customer will have placed more orders
-- than any other customer.

SELECT customer_number FROM orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1
