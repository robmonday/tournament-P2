--This file created for testing only

DROP VIEW wins_by_player; --remove view so you can create it again
CREATE VIEW wins_by_player_excl AS
SELECT players.id, players.name, count(*) AS win_count
FROM players right JOIN matches ON players.id = matches.winner
WHERE status = 'played' AND tie = FALSE
GROUP BY players.id, players.name;

CREATE VIEW wins_by_player AS
SELECT players.id, players.name, wins_by_player_excl.win_count
FROM players RIGHT JOIN wins_by_player_excl ON players.name = wins_by_player_excl.name;

SELECT matches_by_player.name, wins_by_player.win_count, matches_by_player.match_count 
FROM matches_by_player LEFT JOIN wins_by_player
ON matches_by_player.id = wins_by_player.id
ORDER BY wins_by_player.win_count DESC;


/* COMMENTED OUT WORK AREA

--number of games for player1's only
SELECT players.name, count(*) AS match_count
FROM players RIGHT JOIN matches ON (players.id = matches.player1_id)
WHERE status = 'played'
GROUP BY players.name
ORDER BY match_count DESC;

--number of games for player2's only
SELECT players.name, count(*) AS match_count
FROM players RIGHT JOIN matches ON (players.id = matches.player2_id)
WHERE status = 'played'
GROUP BY players.name
ORDER BY match_count DESC;

--number of games by player
CREATE VIEW matches_by_player AS
SELECT players.id, players.name, count(*) AS match_count
FROM players RIGHT JOIN matches ON (players.id = matches.player1_id OR players.id = matches.player2_id)
WHERE status = 'played'
GROUP BY players.id, players.name;

--number of wins by player
CREATE VIEW wins_by_player AS
SELECT players.id, players.name, count(*) AS win_count
FROM players RIGHT JOIN matches ON players.id = matches.winner
WHERE status = 'played' AND tie = FALSE
GROUP BY players.id, players.name
--ORDER BY win_count DESC
;
*/
