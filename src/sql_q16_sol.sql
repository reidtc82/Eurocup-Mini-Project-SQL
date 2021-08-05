--- 16. referees and the number of matches they worked in each
---     venue.
SELECT rm.referee_name,
    sv.venue_name,
    COUNT(match_no) AS worked
FROM match_mast mm 
INNER JOIN referee_mast rm ON mm.referee_id = rm.referee_id 
INNER JOIN soccer_venue sv ON mm.venue_id = sv.venue_id
GROUP BY rm.referee_name, sv.venue_name;

