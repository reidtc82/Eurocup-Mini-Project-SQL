--- 10. all available information about the players under contract to
---    Liverpool F.C. playing for England in EURO Cup 2016.
SELECT DISTINCT pm.*, pio.*, pb.*, gd.*, ps.*
FROM player_mast AS pm
LEFT JOIN player_in_out AS pio 
    ON pm.player_id = pio.player_id
LEFT JOIN player_booked AS pb
    ON pm.player_id = pb.player_id
LEFT JOIN goal_details AS gd
    ON pm.player_id = gd.player_id
LEFT JOIN penalty_shootout AS ps
    ON pm.player_id = ps.player_id
WHERE pm.playing_club LIKE 'Liverpool%' AND
    pm.team_id = 1206;