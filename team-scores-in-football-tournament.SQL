-- Compute the scores of all teams after all matches.
-- Note 1: There might be some teams that did not participate in the tournament. -- LEFT JOIN + IFNULL
-- Note 2: The tournament points of each team include the total points they earned as host
-- team as well as the total points they earned as guest team. -- UNION ALL

-- Solution 1
SELECT t.team_id, t.team_name, IFNULL(SUM(points), 0) AS num_points
FROM Teams AS t
LEFT JOIN
    ((SELECT host_team as team, (CASE WHEN host_goals > guest_goals THEN 3
                                      WHEN host_goals = guest_goals THEN 1
                                      ELSE 0 END) AS points
    FROM Matches)
  UNION ALL
    (SELECT guest_team as team, (CASE WHEN guest_goals > host_goals THEN 3
                                      WHEN guest_goals = host_goals THEN 1
                                      ELSE 0 END) AS points
     FROM Matches)) AS sub
ON (t.team_id = sub.team)
GROUP BY t.team_id
ORDER BY num_points DESC, t.team_id ASC


-- Solution 2
SELECT team_id, team_name, SUM(CASE WHEN t.team_id = m.host_team AND host_goals > guest_goals THEN 3 ELSE 0 END)+
                           SUM(CASE WHEN t.team_id = m.guest_team AND guest_goals > host_goals THEN 3 ELSE 0 END)+
                           SUM(CASE WHEN t.team_id = m.host_team AND host_goals = guest_goals THEN 1 ELSE 0 END)+
                           SUM(CASE WHEN t.team_id = m.guest_team AND guest_goals = host_goals THEN 1 ELSE 0 END)
                           AS num_points
FROM Teams AS t
LEFT JOIN Matches AS m ON (t.team_id = m.host_team OR t.team_id = m.guest_team)
GROUP BY team_id
ORDER BY num_points DESC, team_id ASC
