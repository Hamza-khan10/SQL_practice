--EXERCISE 4
SELECT 
	main_distance,
	COUNT(*) AS runners_number
FROM club.runner
GROUP BY main_distance
HAVING COUNT(*) > 3;

--EXERCISE 5

SELECT 
    e.name AS event_name,
    COUNT(re.runner_id) AS runner_count
FROM club.event e
LEFT JOIN club.runner_event re
    ON e.event_id = re.event_id
GROUP BY e.name
ORDER BY e.name;

--EXERCISE 6
SELECT 
    main_distance,
    COUNT(CASE WHEN age < 20 THEN 1 END) AS under_20,
    COUNT(CASE WHEN age BETWEEN 20 AND 29 THEN 1 END) AS age_20_29,
    COUNT(CASE WHEN age BETWEEN 30 AND 39 THEN 1 END) AS age_30_39,
    COUNT(CASE WHEN age BETWEEN 40 AND 49 THEN 1 END) AS age_40_49,
    COUNT(CASE WHEN age >= 50 THEN 1 END) AS over_50
FROM club.runner
GROUP BY main_distance
ORDER BY main_distance;
