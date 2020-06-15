-- Customers: customer_id | customer_name
-- Orders: order_id | customer_id | product_name

-- Write an SQL query to report the customer_id and customer_name of customers who bought
-- products "A", "B" but did not buy the product "C" since we want to recommend them to buy this product.
-- Return the result table ordered by customer_id.

SELECT c.customer_id, c.customer_name
FROM Customers c
WHERE c.customer_id IN (
  SELECT customer_id FROM Orders WHERE product_name = 'A'
) AND c.customer_id IN (
  SELECT customer_id FROM Orders WHERE product_name = 'B'
) AND c.customer_id NOT IN (
  SELECT customer_id FROM Orders WHERE product_name = 'C'
)
