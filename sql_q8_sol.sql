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