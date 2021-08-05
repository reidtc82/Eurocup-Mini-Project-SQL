--- 6. number of matches that were won by a single point, but
---    do not include matches decided by penalty shootout
SELECT COUNT(match_no)
FROM match_mast
WHERE goal_score = 1 AND decided_by <> 'P' AND results = 'WIN';