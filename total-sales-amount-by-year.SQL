-- Product:
-- product_id | product_name

-- Sales:
-- product_id | period_start | period_end | average_daily_sales

-- Write an SQL query to report the total sales amount of each item for each year
-- with corresponding product_id, product_name and report_year.

-- Dates of the sales years are between 2018 to 2020.
-- Return the result table ordered by product_id and report_year.

-- Recursive CTE
WITH dates AS (
  SELECT MIN(period_start) AS s_date, MAX(period_end) AS e_date FROM Sales
  UNION ALL
  SELECT DATEADD(DAY, 1, s_date), e_date FROM dates
  WHERE s_date <= e_date
)

SELECT CAST(p.product_id AS VARCHAR(200)) AS PRODUCT_ID,
       p.product_name AS PRODUCT_NAME,
       CAST(YEAR(s_date) AS VARCHAR(10)) AS REPORT_YEAR,
       SUM(average_daily_sales) AS TOTAL_AMOUNT
FROM Product p
LEFT JOIN Sales s ON (p.product_id = s.product_id)
LEFT JOIN dates d ON (d.s_date BETWEEN s.period_start AND s.period_end)
GROUP BY p.product_id, p.product_name, YEAR(s_date)
ORDER BY 1, 3
OPTION(maxrecursion 0)
