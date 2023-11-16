CREATE TABLE trades (
	trades_id INT AUTO_INCREMENT PRIMARY KEY,
	trade_result VARCHAR(50),
	trade_date DATETIME
);

CREATE TABLE position (
	position_id INT AUTO_INCREMENT PRIMARY KEY,
	position_name VARCHAR(50)
);

CREATE TABLE game (
	game_id INT AUTO_INCREMENT PRIMARY KEY,
	game_date DATETIME
);

CREATE TABLE conference (
	conference_id INT AUTO_INCREMENT PRIMARY KEY,
	conference_name VARCHAR(50)
);

CREATE TABLE team (
	team_id INT AUTO_INCREMENT PRIMARY KEY,
	team_name VARCHAR(50),
	team_owner VARCHAR(50),
	conference_id INT,
	FOREIGN KEY (conference_id) REFERENCES conference(conference_id)
);

CREATE TABLE teamgame (
	team_id INT,
	game_id INT,
	teamgame_points_scored INT,
	PRIMARY KEY (team_id, game_id),
	FOREIGN KEY (team_id) REFERENCES team(team_id),
	FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE teamtrade (
	trade_id INT,
	team_id INT,
	PRIMARY KEY (trade_id, team_id),
	FOREIGN KEY (trade_id) REFERENCES trades(trade_id),
	FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE player (
	player_id INT AUTO_INCREMENT PRIMARY KEY,
	player_first_name VARCHAR(50),
	player_last_name VARCHAR(50),
	player_salary INT,
	team_id INT,
	FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE playerposition (
	position_id INT,
	player_id INT,
	PRIMARY KEY (position_id, player_id),
	FOREIGN KEY (position_id) REFERENCES position(position_id),
	FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE playertrade (
	trade_id INT,
	player_id INT,
	PRIMARY KEY (trade_id, player_id),
	FOREIGN KEY (trade_id) REFERENCES trades(trade_id),
	FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE injury (
	injury_id INT AUTO_INCREMENT PRIMARY KEY,
	injury_description VARCHAR(100),
	injury_status VARCHAR(50),
	injury_return_date DATETIME
	player_id INT,
	FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE statistics (
	statistics_id INT AUTO_INCREMENT PRIMARY KEY,
	statistics_pass_yds INT,
	statistics_pass_att INT,
	statistics_pass_cmp INT,
	statistics_pass_TD INT,
	statistics_pass_Int INT,
	statistics_pass_Sck INT,
	statistics_pass_SckY INT,
	statistics_rush_yds INT,
	statistics_rush_att INT,
	statistics_rush_TD INT,
	statistics_rush_1st INT,
	statistics_rec_rec INT,
	statistics_rec_yds INT,
	statistics_rec_TD INT,
	statistics_rec_1st INT,
	statistics_tackle_comb INT,
	statistics_tackle_solo INT,
	statistics_tackle_asst INT,
	statistics_tackle_sck INT,
	statistics_int_TD INT,
	statistics_int_yds INT,
	statistics_interc INT,
	statistics_fg_cmp INT,
	statistics_fg_att INT,
	player_id INT,
	game_id INT,
	FOREIGN KEY (player_id) REFERENCES player(player_id),
	FOREIGN KEY (game_id) REFERENCES game(game_id)
);


/* manual test input

INSERT INTO conference (conference_name) VALUES 
('AFC'),
('NFC');

INSERT INTO position (position_name) VALUES 
('Quarterback'),
('Running Back'),
('Wide Receiver'),
('Tight End'),
('Defensive End'),
('Linebacker'),
('Cornerback'),
('Safety');

INSERT INTO trades (trade_result, trade_date) VALUES 
('Successful', '2023-11-16 10:00:00'),
('Failed', '2023-11-15 11:30:00');

INSERT INTO game (game_date) VALUES 
('2023-11-12 13:00:00'),
('2023-11-13 15:30:00');

INSERT INTO team (team_name, team_owner, conference_id) VALUES 
('Dallas Cowboys', 'Jerry Jones', 1),
('Green Bay Packers', 'Mark Murphy', 2),
('Kansas City Chiefs', 'Clark Hunt', 1),
('Tampa Bay Buccaneers', 'Glazer Family', 2);

INSERT INTO teamgame (team_id, game_id, teamgame_points_scored) VALUES 
(1, 1, 28),
(2, 1, 24),
(3, 2, 35),
(4, 2, 31);

INSERT INTO teamtrade (trade_id, team_id) VALUES 
(1, 1),
(1, 3),
(2, 2),
(2, 4);

INSERT INTO player (player_first_name, player_last_name, player_salary, team_id) VALUES 
('Dak', 'Prescott', 4000000, 1),
('Aaron', 'Rodgers', 3300000, 2),
('Patrick', 'Mahomes', 4200000, 3),
('Tom', 'Brady', 3100000, 4);

INSERT INTO playerposition (position_id, player_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4);

INSERT INTO playertrade (trade_id, player_id) VALUES 
(1, 1),
(1, 3),
(2, 2),
(2, 4);

INSERT INTO injury (injury_description, injury_status, injury_return_date, player_id) VALUES 
('Ankle Sprain', 'Out', '2023-11-20 00:00:00', 1),
('Concussion', 'Questionable', '2023-11-18 00:00:00', 2),
('Knee Injury', 'Probable', '2023-11-17 00:00:00', 3),
('Shoulder Strain', 'Probable', '2023-11-19 00:00:00', 4);

INSERT INTO statistics (
    statistics_pass_yds, statistics_pass_att, statistics_pass_cmp, 
    statistics_pass_TD, statistics_pass_Int, statistics_pass_Sck, 
    statistics_pass_SckY, statistics_rush_yds, statistics_rush_att, 
    statistics_rush_TD, statistics_rush_1st, statistics_rec_rec, 
    statistics_rec_yds, statistics_rec_TD, statistics_rec_1st, 
    statistics_tackle_comb, statistics_tackle_solo, statistics_tackle_asst, 
    statistics_tackle_sck, statistics_int_TD, statistics_int_yds, 
    statistics_interc, statistics_fg_cmp, statistics_fg_att, player_id, game_id
) VALUES 
(300, 25, 18, 2, 1, 3, 20, 50, 10, 1, 5, 0, 0, 0, 0, 4, 3, 1, 2, 0, 0, 0, 0, 1),
(250, 30, 20, 3, 0, 2, 15, 40, 8, 0, 3, 0, 0, 0, 0, 2, 2, 0, 1, 0, 0, 0, 0, 2),
(350, 28, 22, 4, 1, 1, 5, 60, 12, 2, 6, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 3),
(280, 27, 19, 3, 0, 3, 25, 55, 11, 1, 4, 0, 0, 0, 0, 4, 3, 1, 1, 0, 0, 0, 0, 4);


*/
