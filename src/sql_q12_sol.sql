--- 12. the total number of goals scored by each position on
---     each country’s team. Do not include positions which scored no goals.
SELECT COUNT(goal_id) AS goal_count,
    pm.posi_to_play,
    pm.team_id
FROM goal_details AS gd
INNER JOIN player_mast AS pm
ON gd.player_id = pm.player_id
GROUP BY pm.posi_to_play, pm.team_id;

