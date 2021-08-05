--- 17. the country where the most assistant referees come from,
---     and the count of the assistant referees.
SELECT COUNT(am.ass_ref_id) AS assistants,
    sc.country_name
FROM asst_referee_mast am
INNER JOIN soccer_country sc ON am.country_id = sc.country_id
GROUP BY sc.country_name
ORDER BY COUNT(am.ass_ref_id) DESC
LIMIT 1;

