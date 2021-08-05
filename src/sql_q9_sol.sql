--- 9. the goalkeeper’s name and jersey number, playing for
---    Germany, who played in Germany’s group stage matches.
-- match_detail -> match_no, team_id, play_stage
-- player_booked -> match_no, team_id, player_id
-- player_mast -> player_id, player_name, jersey_no
-- 1208, G
SELECT DISTINCT player_mast.player_name, 
    player_mast.jersey_no
FROM player_mast
INNER JOIN match_details
ON player_mast.team_id = match_details.team_id
WHERE posi_to_play = 'GK' AND 
    player_mast.team_id = 1208 AND
    match_details.play_stage = 'G';