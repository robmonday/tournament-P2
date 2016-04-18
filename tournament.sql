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
	tie 		boolean DEFAULT FALSE
);

CREATE VIEW standings_data AS
(SELECT p.id, p.name, (CASE WHEN (m.player1_id = m.winner)=TRUE THEN 1 ELSE 0 END) AS win 
FROM matches AS m JOIN players AS P 
ON p.id = m.player1_id)
UNION ALL
(SELECT p.id, p.name, (CASE WHEN (m.player2_id = m.winner)=TRUE THEN 1 ELSE 0 END) AS win 
FROM matches AS m JOIN players AS P 
ON p.id = m.player2_id)
;

CREATE VIEW standings AS
SELECT id, name, sum(win) AS wins, count(win) AS matches 
FROM standings_data 
GROUP BY id, name 
ORDER BY wins DESC;

--importing fictional data for testing purposes
-- \i add_data.sql 
