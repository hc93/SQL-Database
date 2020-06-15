-- Write an SQL query to find the type of weather in each country for November 2019.
-- Return result table in any order.

SELECT country_name, (CASE WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
                           WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
                           ELSE 'Warm' END) AS weather_type
FROM Countries c JOIN Weather w
ON (c.country_id = w.country_id)
WHERE w.day BETWEEN '2019-11-01' AND '2019-11-30'
GROUP BY c.country_id
