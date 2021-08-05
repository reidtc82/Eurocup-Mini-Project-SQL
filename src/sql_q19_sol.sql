--- 19. the number of captains who were also goalkeepers.
SELECT COUNT(player_captain) AS capt_gk
FROM match_captain mc
INNER JOIN player_mast pm ON mc.player_captain = pm.player_id
WHERE pm.posi_to_play = 'GK';

