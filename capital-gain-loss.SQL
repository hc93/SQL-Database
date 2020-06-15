-- Stocks
-- stock_name | operation | operation_day | price
-- primary key: (stock_name, operation_day)
-- operation: ENUM of ('Sell', 'Buy')

-- It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation
-- in a previous day.

-- Write an SQL query to report the capital gain/loss for each stock.
-- The capital gain/loss of a stock is total gain or loss after buying and selling the stock
-- one or many times.
-- Return the result table in any order.

SELECT stock_name,
       SUM(CASE WHEN operation = 'Sell' THEN price ELSE -price END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
