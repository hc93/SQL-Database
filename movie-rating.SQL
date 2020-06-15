-- Movies:
-- movie_id, title
-- movie_id is the primary key

-- Users:
-- user_id, name
-- user_id is the primary key

-- Movie_Rating:
-- movie_id, user_id, rating, created_at
-- (movie_id, user_id) is the primary key

-- Find the name of the user who has rated the greatest number of the movies.
-- In case of a tie, return lexicographically smaller user name.
-- Find the movie name with the highest average rating in February 2020.
-- In case of a tie, return lexicographically smaller movie name.

(
  SELECT u.name AS results
  FROM Movie_Rating r LEFT JOIN Users u
  ON (r.user_id = u.user_id)
  GROUP BY r.user_id
  ORDER BY COUNT(r.movie_id) DESC, u.name
  LIMIT 1
)
UNION
(
  SELECT m.title AS results
  FROM Movie_Rating r LEFT JOIN Movies m
  ON (r.movie_id = m.movie_id)
  WHERE r.created_at LIKE '2020-02%'
  GROUP BY r.movie_id
  ORDER BY AVG(r.rating) DESC, m.title
  LIMIT 1
)
