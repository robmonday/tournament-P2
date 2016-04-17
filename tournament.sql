-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.

\c postgres;
DROP DATABASE tournament; --prevents error from creating table that already exists
CREATE DATABASE tournament;
\c tournament;

CREATE TABLE Players(
	id 			serial PRIMARY KEY,
	name 		varchar(32) NOT NULL, 
	team_color1	varchar(32) DEFAULT 'Not provided',
	team_color2 varchar(32) DEFAULT 'Not provided'
);

CREATE TABLE Venues(
	id			serial PRIMARY KEY,
	venue_name	varchar(64),
	mgr_name	varchar(64),
	addr1		varchar(64),
	addr2		varchar(64),	
	city		varchar(32),
	state 		varchar(16),
	zip			int
);

CREATE TABLE Matches(
	id 			serial PRIMARY KEY,
	round 		int NOT NULL CHECK (round > 0),
	venue_id	int NOT NULL REFERENCES venues(id),
	game_time 	timestamp DEFAULT current_timestamp,
	player1_id	int REFERENCES Players(id),
	player2_id	int REFERENCES Players(id),
	status		varchar(32) CHECK (status = 'played' OR status = 'scheduled' OR status = 'reserved') DEFAULT 'reserved',
	p1_score	int CHECK (p1_score>=0),
	p2_score	int CHECK (p2_score>=0),
	winner		int REFERENCES players(id),
	loser		int REFERENCES players(id),
	tie 		boolean
);

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