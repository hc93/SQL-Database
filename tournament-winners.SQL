-- You may assume that, in each match, players belongs to the same group.
-- The winner in each group is the player who scored the maximum total points within the group.
-- In the case of a tie, the lowest player_id wins.

-- Write an SQL query to find the winner in each group.

-- Solution 1
SELECT group_id AS GROUP_ID, min(player_id) AS PLAYER_ID
FROM Players JOIN
   (SELECT player, SUM(score) AS total_score
    FROM (
        SELECT first_player AS player, first_score AS score FROM Matches
        UNION ALL
        SELECT second_player AS player, second_score AS score FROM Matches ) s
    GROUP BY player) ps
ON (Players.player_id = ps.player)
WHERE (group_id, total_score) IN (
        SELECT group_id, MAX(total_score) AS max_total_score
        FROM Players JOIN
            ( SELECT player, SUM(score) AS total_score
              FROM (
                  SELECT first_player AS player, first_score AS score FROM Matches
                  UNION ALL
                  SELECT second_player AS player, second_score AS score FROM Matches ) s
              GROUP BY player ) ps
        ON (Players.player_id = ps.player)
        GROUP BY group_id
      )
GROUP BY group_id


-- Solution 2: Window function
SELECT group_id AS GROUP_ID, player_id AS PLAYER_ID
FROM (
    SELECT p.player_id, p.group_id,
           RANK() OVER(PARTITION BY p.group_id ORDER BY ps.total_score DESC, p.player_id ASC) AS rk
    FROM Players p JOIN (
      SELECT player, SUM(score) AS total_score
      FROM
          ( SELECT first_player AS player, first_score AS score FROM Matches
            UNION ALL
            SELECT second_player AS player, second_score AS score FROM Matches ) s
      GROUP BY player ) ps
    ON (p.player_id = ps.player)
) t
WHERE t.rk = 1
