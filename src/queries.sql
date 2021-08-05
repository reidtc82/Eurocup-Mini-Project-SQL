--- 1. When Euro Cup 2016 season started
SELECT play_date
FROM match_mast
ORDER BY play_date ASC
LIMIT 1;

--- 2. Number of matches won by penalty shootout
SELECT COUNT(*)
FROM match_details
WHERE decided_by = 'P' AND win_lose = 'W';

--- 3. match number, date, and score for matches in which 
---    no stoppage time was added in the 1st half.
SELECT match_no, play_date, goal_score
FROM match_mast
WHERE stop1_sec = 0;

--- 4. list showing the number of substitutions that
---    happened in various stages of play for the entire tournament.
SELECT COUNT(in_out) AS substitutions, play_stage
FROM player_in_out
INNER JOIN match_mast
USING(match_no)
WHERE in_out = 'O'
GROUP BY 
play_stage;

--- 5. number of bookings that happened in stoppage time
SELECT COUNT(*)
FROM player_booked
WHERE play_schedule = 'ST';

--- 6. number of matches that were won by a single point, but
---    do not include matches decided by penalty shootout
SELECT COUNT(match_no)
FROM match_mast
WHERE goal_score = 1 AND decided_by <> 'P' AND results = 'WIN';

--- 7. all the venues where matches with penalty shootouts were
---    played.
SELECT venue_name
FROM soccer_venue
INNER JOIN match_mast
USING(venue_id)
WHERE decided_by = 'P';

--- 8. the match number for the game with the highest number of
---    penalty shots, and which countries played that match.
SELECT mc.match_no, sc1.country_name AS country_a, sc2.country_name AS country_b, ps.penalty_kicks
FROM
(SELECT m1.match_no, m1.team_id AS team_a, m2.team_id AS team_b
FROM match_details AS m1, match_details AS m2
WHERE m1.team_id <> m2.team_id AND 
      m1.match_no = m2.match_no) AS mc
INNER JOIN (SELECT country_id, country_name FROM soccer_country) AS sc1 
ON mc.team_a = sc1.country_id 
INNER JOIN (SELECT country_id, country_name FROM soccer_country) AS sc2 
ON mc.team_b = sc2.country_id 
INNER JOIN (SELECT match_no, COUNT(kick_id) AS penalty_kicks 
			FROM penalty_shootout 
			GROUP BY match_no
			ORDER BY penalty_kicks DESC
			LIMIT 1) AS ps 
ON ps.match_no = mc.match_no
LIMIT 1;

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

--- 11. the players, their jersey number, and playing club who were
---     the goalkeepers for England in EURO Cup 2016.
SELECT player_name, jersey_no, playing_club
FROM player_mast
WHERE team_id = 1206 AND posi_to_play = 'GK';

--- 12. the total number of goals scored by each position on
---     each country’s team. Do not include positions which scored no goals.
SELECT COUNT(goal_id) AS goal_count,
    pm.posi_to_play,
    pm.team_id
FROM goal_details AS gd
INNER JOIN player_mast AS pm
ON gd.player_id = pm.player_id
GROUP BY pm.posi_to_play, pm.team_id;

--- 13. all the defenders who scored a goal for their teams.
--- DF
SELECT DISTINCT pm.player_id, pm.player_name
FROM goal_details gd
INNER JOIN player_mast pm
ON pm.player_id = gd.player_id
WHERE pm.posi_to_play = 'DF';

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

--- 16. referees and the number of matches they worked in each
---     venue.
SELECT rm.referee_name,
    sv.venue_name,
    COUNT(match_no) AS worked
FROM match_mast mm 
INNER JOIN referee_mast rm ON mm.referee_id = rm.referee_id 
INNER JOIN soccer_venue sv ON mm.venue_id = sv.venue_id
GROUP BY rm.referee_name, sv.venue_name;

--- 17. the country where the most assistant referees come from,
---     and the count of the assistant referees.
SELECT COUNT(am.ass_ref_id) AS assistants,
    sc.country_name
FROM asst_referee_mast am
INNER JOIN soccer_country sc ON am.country_id = sc.country_id
GROUP BY sc.country_name
ORDER BY COUNT(am.ass_ref_id) DESC
LIMIT 1;

--- 18. the highest number of foul cards given in one match.
SELECT COUNT(player_id) bookings,
    match_no
FROM player_booked
GROUP BY match_no
ORDER BY COUNT(player_id) DESC
LIMIT 1;

--- 19. the number of captains who were also goalkeepers.
SELECT COUNT(player_captain) AS capt_gk
FROM match_captain mc
INNER JOIN player_mast pm ON mc.player_captain = pm.player_id
WHERE pm.posi_to_play = 'GK';

--- 20. the substitute players who came into the field in the first
---     half of play, within a normal play schedule.
--- in_out = I
SELECT pm.player_name
FROM player_in_out pio
INNER JOIN player_mast pm ON pio.player_id = pm.player_id
WHERE in_out = 'I' AND play_half < 2 AND play_schedule = 'NT';