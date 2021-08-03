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


--- 10. all available information about the players under contract to
---    Liverpool F.C. playing for England in EURO Cup 2016.


--- 11. the players, their jersey number, and playing club who were
---     the goalkeepers for England in EURO Cup 2016.


--- 12. the total number of goals scored by each position on
---     each country’s team. Do not include positions which scored no goals.


--- 13. all the defenders who scored a goal for their teams.


--- 14. referees and the number of bookings they made for the
---     entire tournament. Sort your answer by the number of bookings in descending order.


--- 15. the referees who booked the most number of players.


--- 16. referees and the number of matches they worked in each
---     venue.


--- 17. the country where the most assistant referees come from,
---     and the count of the assistant referees.


--- 18. the highest number of foul cards given in one match.


--- 19. the number of captains who were also goalkeepers.


--- 20. the substitute players who came into the field in the first
---     half of play, within a normal play schedule.