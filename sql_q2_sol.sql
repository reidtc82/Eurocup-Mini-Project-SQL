--- 2. Number of matches won by penalty shootout
SELECT COUNT(*)
FROM match_details
WHERE decided_by = 'P' AND win_lose = 'W';