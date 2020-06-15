-- Write an SQL query to find the ctr of each Ad.
-- Round ctr to 2 decimal points. Order the result table by ctr in descending order
-- and by ad_id in ascending order in case of a tie.

-- my solution: IF, SUM(CASE WHEN...)
SELECT t.ad_id,
       IF(t.num_clicks + t.num_views = 0, 0, ROUND(100*t.num_clicks/(t.num_clicks + t.num_views), 2)) AS ctr
FROM
    ( SELECT ad_id,
             SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) AS num_clicks,
             SUM(CASE WHEN action = 'Viewed' THEN 1 ELSE 0 END) AS num_views
      FROM Ads
      GROUP BY ad_id ) t
ORDER BY ctr DESC, t.ad_id ASC

-- another solution: COALESCE
SELECT ad_id,
       COALESCE(ROUND(SUM(action='Clicked') / (SUM(action='Clicked')+SUM(action='Viewed')) * 100, 2), 0) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC
