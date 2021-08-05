--- 11. the players, their jersey number, and playing club who were
---     the goalkeepers for England in EURO Cup 2016.
SELECT player_name, jersey_no, playing_club
FROM player_mast
WHERE team_id = 1206 AND posi_to_play = 'GK';

