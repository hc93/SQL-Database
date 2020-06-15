-- Write an SQL query to find the following for each invoice_id:
-- customer_name: The name of the customer the invoice is related to.
-- price: The price of the invoice.
-- contacts_cnt: The number of contacts related to the customer.
-- trusted_contacts_cnt: The number of contacts related to the customer and at the same time
-- they are customers to the shop. (i.e His/Her email exists in the Customers table.)
-- Order the result table by invoice_id.

SELECT i.invoice_id, t.customer_name, i.price, t.contacts_cnt, t.trusted_contacts_cnt
FROM Invoices i
LEFT JOIN (
    SELECT c1.customer_id, c1.customer_name,
           COUNT(c2.contact_name) AS contacts_cnt,
           SUM(CASE WHEN c2.contact_name IN (SELECT customer_name FROM Customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt
    FROM Customers c1
    LEFT JOIN Contacts c2
    ON (c1.customer_id = c2.user_id)
    GROUP BY c1.customer_id
) t
ON i.user_id = t.customer_id
ORDER BY i.invoice_id
