--Set up players
INSERT INTO players (name, team_color1, team_color2) VALUES ('Duke','Dark Blue','White');
INSERT INTO players (name, team_color1, team_color2) VALUES ('UNC','Light Blue','White');
INSERT INTO players (name, team_color1, team_color2) VALUES ('Harvard','Crimson','White');
INSERT INTO players (name, team_color1, team_color2) VALUES ('Tennessee','Light Orange','White');
INSERT INTO players (name, team_color1, team_color2) VALUES ('Clemson','Orange','Purple');
INSERT INTO players (name, team_color1, team_color2) VALUES ('Vanderbilt','Black', 'Gold');

--Set up venues
INSERT INTO venues (venue_name, state) VALUES ('Thompson Bowling Arena', 'TN');
INSERT INTO venues (venue_name, state) VALUES ('Littlejohn Colosseum','SC');
INSERT INTO venues (venue_name, state) VALUES ('Cameron','NC');
INSERT INTO venues (venue_name, state) VALUES ('McCamish Pavilion','GA');

--Reserve times and venues for round 1
INSERT INTO matches (round, venue_id, game_time) VALUES (1,1,'2016-06-01 06:00:00 -6:00');
INSERT INTO matches (round, venue_id, game_time) VALUES (1,2,'2016-06-01 07:00:00 -6:00');
INSERT INTO matches (round, venue_id, game_time) VALUES (1,3,'2016-06-01 08:00:00 -6:00');

--Reserve times and venues for round 2
INSERT INTO matches (round, venue_id, game_time) VALUES (2,4,'2016-06-08 06:00:00 -6:00');
INSERT INTO matches (round, venue_id, game_time) VALUES (2,4,'2016-06-08 07:00:00 -6:00');
INSERT INTO matches (round, venue_id, game_time) VALUES (2,4,'2016-06-08 08:00:00 -6:00');

--Reserve times and venues for round 3
INSERT INTO matches (round, venue_id, game_time) VALUES (3,1,'2016-06-15 06:00:00 -6:00');
INSERT INTO matches (round, venue_id, game_time) VALUES (3,1,'2016-06-15 07:00:00 -6:00');
INSERT INTO matches (round, venue_id, game_time) VALUES (3,1,'2016-06-15 08:00:00 -6:00');

--Schedule games for round 1
UPDATE matches SET player1_id = 1, player2_id = 2, status = 'scheduled' WHERE id = 1;
UPDATE matches SET player1_id = 3, player2_id = 4, status = 'scheduled' WHERE id = 2;
UPDATE matches SET player1_id = 5, player2_id = 6, status = 'scheduled' WHERE id = 3;

--Record results after round 1 games
UPDATE matches SET status = 'played', p1_score = 20, p2_score = 22, winner = 2, loser = 1, tie = FALSE WHERE id = 1;
UPDATE matches SET status = 'played', p1_score = 77, p2_score = 43, winner = 3, loser = 4, tie = FALSE WHERE id = 2;
UPDATE matches SET status = 'played', p1_score = 51, p2_score = 51, winner = NULL, loser = NULL, tie = TRUE WHERE id = 3;

--Schedule games for round 2
UPDATE matches SET player1_id = 2, player2_id = 5, status = 'scheduled' WHERE id = 4;
UPDATE matches SET player1_id = 3, player2_id = 6, status = 'scheduled' WHERE id = 5;
UPDATE matches SET player1_id = 1, player2_id = 4, status = 'scheduled' WHERE id = 6;

--Record results after round 2 games
UPDATE matches SET status = 'played', p1_score = 33, p2_score = 28, winner = 2, loser = 5, tie = FALSE WHERE id = 4;
UPDATE matches SET status = 'played', p1_score = 32, p2_score = 33, winner = 6, loser = 3, tie = FALSE WHERE id = 5;
UPDATE matches SET status = 'played', p1_score = 56, p2_score = 51, winner = 1, loser = 4, tie = FALSE WHERE id = 6;
/*


*/
