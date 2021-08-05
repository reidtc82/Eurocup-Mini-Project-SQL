--- 13. all the defenders who scored a goal for their teams.
--- DF
SELECT DISTINCT pm.player_id, pm.player_name
FROM goal_details gd
INNER JOIN player_mast pm
ON pm.player_id = gd.player_id
WHERE pm.posi_to_play = 'DF';

