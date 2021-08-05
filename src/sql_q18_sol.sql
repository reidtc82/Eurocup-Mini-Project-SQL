--- 18. the highest number of foul cards given in one match.
SELECT COUNT(player_id) bookings,
    match_no
FROM player_booked
GROUP BY match_no
ORDER BY COUNT(player_id) DESC
LIMIT 1;

