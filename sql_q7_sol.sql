--- 7. all the venues where matches with penalty shootouts were
---    played.
SELECT venue_name
FROM soccer_venue
INNER JOIN match_mast
USING(venue_id)
WHERE decided_by = 'P';