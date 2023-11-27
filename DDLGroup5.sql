CREATE DATABASE group_5;

CREATE TABLE trade (
	trade_id INT AUTO_INCREMENT PRIMARY KEY,
	trade_result VARCHAR(50),
	trade_date DATETIME
);

CREATE TABLE positions (
	positions_id INT AUTO_INCREMENT PRIMARY KEY,
	positions_name VARCHAR(50)
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
	FOREIGN KEY (trade_id) REFERENCES trade(trade_id),
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

CREATE TABLE playerpositions (
	positions_id INT,
	player_id INT,
	PRIMARY KEY (positions_id, player_id),
	FOREIGN KEY (positions_id) REFERENCES positions(positions_id),
	FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE playertrade (
	trade_id INT,
	player_id INT,
	PRIMARY KEY (trade_id, player_id),
	FOREIGN KEY (trade_id) REFERENCES trade(trade_id),
	FOREIGN KEY (player_id) REFERENCES player(player_id)
);

CREATE TABLE injury (
	injury_id INT AUTO_INCREMENT PRIMARY KEY,
	injury_description VARCHAR(100),
	injury_status VARCHAR(50),
	injury_return_date DATETIME,
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
	FOREIGN KEY (player_id) REFERENCES player(player_id)
);

/* data inserts */
INSERT INTO positions (positions_name) VALUES 
('Quarterback'),
('Running Back'),
('Wide Receiver'),
('Tight End'),
('Defensive End'),
('Linebacker'),
('Cornerback'),
('Safety');

INSERT INTO trade (trade_result, trade_date) VALUES 
('Successful', '2023-11-16 10:00:00'),
('Failed', '2023-11-15 11:30:00');

INSERT INTO game (game_date) VALUES 
('2023-11-12 13:00:00'),
('2023-11-13 15:30:00');

INSERT INTO conference (conference_name) VALUES 
('AFC'),
('NFC');

INSERT INTO team (team_name, team_owner, conference_id) VALUES 
('Dallas Cowboys', 'Jerry Jones', 1),
('Green Bay Packers', 'Mark Murphy', 2),
('Kansas City Chiefs', 'Clark Hunt', 1),
('Tampa Bay Buccaneers', 'Glazer Family', 2),
('San Francisco 49ers', 'Denise DeBartolo York', 2),
('Tennessee Titans', 'Amy Adams Strunk', 1),
('Las Vegas Raiders', 'Davis Family', 1),
('Jacksonville Jaguars', 'Shahid Khan', 1),
('Indianapolis Colts', 'Jim Irsay', 1),
('Buffalo Bills', 'Terry Pegula', 1),
('Philadelphia Eagles', 'Jeffrey Lurie', 2),
('Atlanta Falcons', 'Arthur Blank', 2),
('Cincinnati Bengals', 'Michael Brown', 1),
('Miami Dolphins', 'Stephen M. Ross', 1),
('Seattle Seahawks', 'The Paul Allen Trust', 2),
('New York Giants', 'John Kevin Mara', 2),
('Baltimore Ravens', 'Steve Bisciotti', 1),
('Cleveland Browns', 'Haslam Family', 1),
('New York Jets', 'Woody Johnson', 1),
('Detroit Lions', 'Sheila Ford Hamp', 2),
('Washington Commanders', 'Josh Harris', 2),
('New England Patriots', 'Robert Kraft', 1),
('Pittsburgh Steelers', 'Rooney family', 1),
('Minnesota Vikings', 'Zygi Wilf', 2),
('Los Angeles Chargers', 'Dean Spanos', 1)
ON DUPLICATE KEY UPDATE team_id = LAST_INSERT_ID(team_id);

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
('Dak', 'Prescott', 4000000, (SELECT team_id FROM team WHERE team_name = 'Dallas Cowboys')),
('Aaron', 'Rodgers', 3300000, (SELECT team_id FROM team WHERE team_name = 'Green Bay Packers')),
('Patrick', 'Mahomes', 4200000, (SELECT team_id FROM team WHERE team_name = 'Kansas City Chiefs')),
('Tom', 'Brady', 3100000, (SELECT team_id FROM team WHERE team_name = 'Tampa Bay Buccaneers')),
('Christian', 'McCaffrey', 64000000, (SELECT team_id FROM team WHERE team_name = 'San Francisco 49ers')),
('Derrick', 'Henry', 1351982, (SELECT team_id FROM team WHERE team_name = 'Tennessee Titans')),
('Josh', 'Jacobs', 7590996, (SELECT team_id FROM team WHERE team_name = 'Las Vegas Raiders')),
('Travis', 'Etienne', 3224526, (SELECT team_id FROM team WHERE team_name = 'Jacksonville Jaguars')),
('Zack', 'Moss', 1153079, (SELECT team_id FROM team WHERE team_name = 'Indianapolis Colts')),
('James', 'Cook', 1458014, (SELECT team_id FROM team WHERE team_name = 'Buffalo Bills')),
('D\'Andre', 'Swift', 2134729, (SELECT team_id FROM team WHERE team_name = 'Philadelphia Eagles')),
('Bijan', 'Robinson', 5490000, (SELECT team_id FROM team WHERE team_name = 'Atlanta Falcons')),
('Joe', 'Mixon', 5750000, (SELECT team_id FROM team WHERE team_name = 'Cincinnati Bengals')),
('Raheem', 'Mostert', 2800000, (SELECT team_id FROM team WHERE team_name = 'Miami Dolphins')),
('Kenneth', 'Walker III', 2110395, (SELECT team_id FROM team WHERE team_name = 'Seattle Seahawks')),
('Saquon', 'Barkley', 8091000, (SELECT team_id FROM team WHERE team_name = 'New York Giants')),
('Gus', 'Edwards', 3384000, (SELECT team_id FROM team WHERE team_name = 'Baltimore Ravens')),
('Lamar', 'Jackson',7500000, (SELECT team_id FROM team WHERE team_name = 'Baltimore Ravens')),
('Jerome', 'Ford', 995537, (SELECT team_id FROM team WHERE team_name = 'Cleveland Browns')),
('Tony', 'Pollard', 10091000, (SELECT team_id FROM team WHERE team_name = 'Dallas Cowboys')),
('Isiah', 'Pacheco', 934777, (SELECT team_id FROM team WHERE team_name = 'Kansas City Chiefs')),
('Breece', 'Hall', 2253694, (SELECT team_id FROM team WHERE team_name = 'New York Jets')),
('David', 'Montgomery', 6000000, (SELECT team_id FROM team WHERE team_name = 'Detroit Lions')),
('Brian', 'Robinson', 1261227, (SELECT team_id FROM team WHERE team_name = 'Washington Commanders')),
('Rhamondre', 'Stevenson', 1057264, (SELECT team_id FROM team WHERE team_name = 'New England Patriots')),
('Jahmyr', 'Gibbs', 4461283, (SELECT team_id FROM team WHERE team_name = 'Detroit Lions')),
('Najee', 'Harris', 3261862, (SELECT team_id FROM team WHERE team_name = 'Pittsburgh Steelers')),
('Alexander', 'Mattison', 1100000, (SELECT team_id FROM team WHERE team_name = 'Minnesota Vikings')),
('De\'Von', 'Achane', 1359362, (SELECT team_id FROM team WHERE team_name = 'Miami Dolphins')),
('Keenan', 'Allen', 613800, (SELECT team_id FROM team WHERE team_name = 'Los Angeles Chargers')),
('Stefon', 'Digs', 1165000, (SELECT team_id FROM team WHERE team_name = 'Buffalo Bills'))
ON DUPLICATE KEY UPDATE player_id = LAST_INSERT_ID(player_id);

INSERT INTO playerpositions (positions_id, player_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(3, 30),
(3, 31);

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

INSERT INTO statistics (player_id, statistics_rush_yds, statistics_rush_TD, statistics_rush_1st) VALUES 
((SELECT player_id FROM player WHERE player_first_name = 'Christian' AND player_last_name = 'McCaffrey'), 747, 9, 44),
((SELECT player_id FROM player WHERE player_first_name = 'Derrick' AND player_last_name = 'Henry'), 625, 4, 30),
((SELECT player_id FROM player WHERE player_first_name = 'Josh' AND player_last_name = 'Jacobs'), 622, 5, 30),
((SELECT player_id FROM player WHERE player_first_name = 'Travis' AND player_last_name = 'Etienne'), 618, 7, 33),
((SELECT player_id FROM player WHERE player_first_name = 'Zack' AND player_last_name = 'Moss'), 617, 5, 31),
((SELECT player_id FROM player WHERE player_first_name = 'James' AND player_last_name = 'Cook'), 615, 1, 31),
((SELECT player_id FROM player WHERE player_first_name = 'D\'Andre' AND player_last_name = 'Swift'), 614, 3, 30),
((SELECT player_id FROM player WHERE player_first_name = 'Bijan' AND player_last_name = 'Robinson'), 612, 2, 32),
((SELECT player_id FROM player WHERE player_first_name = 'Joe' AND player_last_name = 'Mixon'), 605, 4, 38),
((SELECT player_id FROM player WHERE player_first_name = 'Raheem' AND player_last_name = 'Mostert'), 605, 11, 32),
((SELECT player_id FROM player WHERE player_first_name = 'Kenneth' AND player_last_name = 'Walker III'), 595, 6, 28),
((SELECT player_id FROM player WHERE player_first_name = 'Saquon' AND player_last_name = 'Barkley'), 568, 1, 26),
((SELECT player_id FROM player WHERE player_first_name = 'Gus' AND player_last_name = 'Edwards'), 564, 10, 36),
((SELECT player_id FROM player WHERE player_first_name = 'Lamar' AND player_last_name = 'Jackson'), 535, 5, 35),
((SELECT player_id FROM player WHERE player_first_name = 'Jerome' AND player_last_name = 'Ford'), 532, 2, 19),
((SELECT player_id FROM player WHERE player_first_name = 'Tony' AND player_last_name = 'Pollard'), 529, 2, 27),
((SELECT player_id FROM player WHERE player_first_name = 'Isiah' AND player_last_name = 'Pacheco'), 525, 3, 30),
((SELECT player_id FROM player WHERE player_first_name = 'Breece' AND player_last_name = 'Hall'), 521, 2, 17),
((SELECT player_id FROM player WHERE player_first_name = 'David' AND player_last_name = 'Montgomery'), 501, 7, 26),
((SELECT player_id FROM player WHERE player_first_name = 'Brian' AND player_last_name = 'Robinson'), 485, 5, 31),
((SELECT player_id FROM player WHERE player_first_name = 'Rhamondre' AND player_last_name = 'Stevenson'), 482, 3, 25),
((SELECT player_id FROM player WHERE player_first_name = 'Jahmyr' AND player_last_name = 'Gibbs'), 476, 4, 20),
((SELECT player_id FROM player WHERE player_first_name = 'Najee' AND player_last_name = 'Harris'), 464, 3, 23),
((SELECT player_id FROM player WHERE player_first_name = 'Alexander' AND player_last_name = 'Mattison'), 461, 0, 18),
((SELECT player_id FROM player WHERE player_first_name = 'De\'Von' AND player_last_name = 'Achane'), 460, 5, 15)
;
INSERT INTO statistics (player_id, statistics_rec_yds, statistics_rec_rec, statistics_rec_TD, statistics_rec_1st) VALUES 
((SELECT player_id FROM player WHERE player_first_name = 'Keenan' AND player_last_name = 'Allen'), 895, 73, 6, 41),
((SELECT player_id FROM player WHERE player_first_name = 'Stefon' AND player_last_name = 'Diggs'),895, 73, 6, 41)
;
