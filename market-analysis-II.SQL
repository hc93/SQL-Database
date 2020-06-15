-- Write an SQL query to find for each user, whether the brand of the second item
-- (by date) they sold is their favorite brand.
-- If a user sold less than two items, report the answer for that user as no.
-- It is guaranteed that no seller sold more than one item on a day.


-- Note: The hardest part is to find the second item each user sold.
-- We can use self-join with multiple conditions.

-- solution 1
SELECT u.user_id AS seller_id,
(CASE WHEN u.favorite_brand = i.item_brand THEN 'yes' ELSE 'no' END) AS 2nd_item_fav_brand
FROM Users u LEFT JOIN (
    SELECT o1.seller_id, o1.item_id
    FROM Orders o1
    WHERE (SELECT COUNT(order_id) FROM Orders o2
           WHERE o1.seller_id = o2.seller_id AND o1.order_date > o2.order_date) = 1) t
ON (u.user_id = t.seller_id)
LEFT JOIN Items i
ON (t.item_id = i.item_id)
ORDER BY u.user_id

-- solution 2
SELECT u.user_id AS seller_id,
IF(u.favorite_brand = i.item_brand, 'yes', 'no') AS 2nd_item_fav_brand
FROM Users u LEFT JOIN (
    SELECT o1.seller_id, o1.item_id, o1.order_date
    FROM Orders o1 JOIN Orders o2
    ON (o1.seller_id = o2.seller_id AND o1.order_date > o2.order_date)
    GROUP BY o1.seller_id, o1.order_date
    HAVING COUNT(o1.order_id) = 1
) t ON (u.user_id = t.seller_id)
LEFT JOIN Items i
ON (t.item_id = i.item_id)
ORDER BY u.user_id
