--- 4. list showing the number of substitutions that
---    happened in various stages of play for the entire tournament.
SELECT COUNT(in_out) AS substitutions, play_stage
FROM player_in_out
INNER JOIN match_mast
USING(match_no)
WHERE in_out = 'O'
GROUP BY 
play_stage;