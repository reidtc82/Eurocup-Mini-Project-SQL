--- 15. the referees who booked the most number of players.
SELECT 
    COUNT(pb.player_id) AS players_booked,
    mm.referee_id
FROM player_booked pb
INNER JOIN match_mast mm
    USING(match_no)
GROUP BY mm.referee_id
ORDER BY COUNT(pb.player_id) DESC
LIMIT 1;

