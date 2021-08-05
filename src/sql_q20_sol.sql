--- 20. the substitute players who came into the field in the first
---     half of play, within a normal play schedule.
--- in_out = I
SELECT pm.player_name
FROM player_in_out pio
INNER JOIN player_mast pm ON pio.player_id = pm.player_id
WHERE in_out = 'I' AND play_half < 2 AND play_schedule = 'NT';