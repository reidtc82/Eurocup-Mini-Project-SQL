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