-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.

\c postgres;
DROP DATABASE tournament; --prevents error from creating table that already exists
CREATE DATABASE tournament;
\c tournament;

CREATE TABLE Players (
	name 		varchar(32) PRIMARY KEY, 
	team_color1	varchar(32),
	team_color2 varchar(32)
);

CREATE TABLE Matches(
	id serial,
	tournament 	varchar(32) DEFAULT 'Current',
	round 		int NOT NULL CHECK (round > 0),
	game_time 	timestamp DEFAULT current_timestamp,
	player1 	varchar(32) NOT NULL REFERENCES Players(name),
	player2 	varchar(32) NOT NULL REFERENCES Players(name),
	winner 		varchar(32) NOT NULL REFERENCES Players(name), 
	loser 		varchar(32) NOT NULL REFERENCES Players(name), 
	PRIMARY KEY (tournament, round, player1, player2)
);

