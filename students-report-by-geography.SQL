-- Pivot the continent column in this table so that each name is sorted alphabetically
-- and displayed underneath its corresponding continent.
-- The output headers should be America, Asia and Europe respectively.
-- It is guaranteed that the student number from America is no less than either Asia or Europe.

-- Window function + FULL JOIN
SELECT amer.name AS America, asia.name AS Asia, euro.name AS Europe
FROM
    (SELECT ROW_NUMBER() OVER(ORDER BY name) AS id, name FROM student WHERE continent = 'America') amer
  FULL JOIN
    (SELECT ROW_NUMBER() OVER(ORDER BY name) AS id, name FROM student WHERE continent = 'Asia') asia
  ON amer.id = asia.id
  FULL JOIN
    (SELECT ROW_NUMBER() OVER(ORDER BY name) AS id, name FROM student WHERE continent = 'Europe') euro
  ON euro.id = asia.id OR euro.id = amer.id
