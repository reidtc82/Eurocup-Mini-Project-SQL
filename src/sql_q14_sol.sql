--- 14. referees and the number of bookings they made for the
---     entire tournament. Sort your answer by the number of bookings in descending order.
SELECT COUNT(pb.match_no) AS bookings,
    rm.referee_name
FROM player_booked pb
INNER JOIN match_mast mm
    ON pb.match_no = mm.match_no
INNER JOIN referee_mast rm
    ON mm.referee_id = rm.referee_id
GROUP BY rm.referee_name
ORDER BY COUNT(pb.match_no) DESC;

