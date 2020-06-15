-- Write a SQL query to find the median salary of each company.
-- Bonus points if you can solve it without using any built-in SQL functions.

SELECT Id, Company, Salary
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY Company ORDER BY Salary ASC, Id ASC) AS rn_asc,
           ROW_NUMBER() OVER(PARTITION BY Company ORDER BY Salary DESC, Id DESC) AS rn_desc
    FROM Employee
) t
WHERE rn_asc BETWEEN rn_desc-1 AND rn_desc+1
ORDER BY Company, Salary
