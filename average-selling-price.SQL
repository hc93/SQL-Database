-- Write an SQL query to find the average selling price for each product.
-- average_price should be rounded to 2 decimal places.
-- For each product_id there will be no two overlapping periods.
-- That means there will be no two intersecting periods for the same product_id.


SELECT p.product_id,
  ROUND(SUM(p.price * u.units)/SUM(u.units), 2) AS average_price
FROM Prices p JOIN UnitsSold u
ON (p.product_id = u.product_id) AND (u.purchase_date BETWEEN p.start_date AND p.end_date)
GROUP BY product_id
