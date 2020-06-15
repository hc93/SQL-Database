-- Write an SQL query that reports for each player and date, how many games played so far by the player.
-- That is, the total number of games played by the player until that date.

-- Solution 1: Self join
SELECT a1.player_id, a1.event_date, SUM(a2.games_played) AS games_played_so_far
FROM Activity a1
JOIN Activity a2
ON (a1.player_id = a2.player_id AND a2.event_date <= a1.event_date)
GROUP BY a1.player_id, a1.event_date


-- Solution 2: Window function
SELECT player_id, event_date,
       SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) AS games_played_so_far
FROM Activity
