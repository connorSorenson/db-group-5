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
	player_salary VARCHAR(50),
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
	player_id INT
	game_id INT,
	FOREIGN KEY (player_id) REFERENCES player(player_id),
	FOREIGN KEY (game_id) REFERENCES game(game_id)
);
