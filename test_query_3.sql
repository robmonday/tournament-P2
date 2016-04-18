SELECT name, sum(win) AS win_count, count(win) AS match_count FROM standings_data GROUP BY name ORDER BY win_count DESC;

/*

CREATE VIEW standings_data AS
(SELECT p.name, (CASE WHEN (m.player1_id = m.winner)=TRUE THEN 1 ELSE 0 END) AS win 
FROM matches AS m JOIN players AS P 
ON p.id = m.player1_id)
UNION ALL
(SELECT p.name, (CASE WHEN (m.player2_id = m.winner)=TRUE THEN 1 ELSE 0 END) AS win 
FROM matches AS m JOIN players AS P 
ON p.id = m.player2_id)
;

*/