-- Salaries:
-- company_id | employee_id | employee_name | salary

SELECT s.company_id, employee_id, employee_name,
       ROUND(salary * (1-tax_rate)) AS salary
FROM Salaries s
LEFT JOIN
( SELECT company_id,
       (CASE WHEN MAX(salary) > 10000 THEN 0.49
        WHEN MAX(salary) < 1000 THEN 0
        ELSE 0.24 END) AS tax_rate
  FROM Salaries
  GROUP BY company_id ) tax
ON s.company_id = tax.company_id
