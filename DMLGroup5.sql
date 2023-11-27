#All Quieries
#1
SELECT
	player_id,
	MAX(player_salary) AS max_salary,
	MAX(player_salary) AS avg_salary
FROM
	player
GROUP BY
	player_id;
#2
SELECT DISTINCT
	CONCAT(player_first_name, ‘ ‘, player_last_name) AS player_name,
	player.player_id,
	player_salary,
	team_name
FROM
	player
JOIN
	team ON player.team_id = team.team_id;
#3
SELECT 
    p.player_first_name, 
    p.player_last_name, 
    s.statistics_rush_yds
FROM 
    player p
INNER JOIN 
    statistics s ON p.player_id = s.player_id
WHERE 
    p.team_id = (
        SELECT 
            t.team_id 
        FROM 
            team t 
        WHERE 
            t.team_name LIKE '%San Francisco%'
    );
#4
SELECT 
    p.player_first_name,
    p.player_last_name,
    t.team_name,
    s.statistics_rush_yds
FROM 
    player p
JOIN 
    team t ON p.team_id = t.team_id
JOIN 
    statistics s ON p.player_id = s.player_id
ORDER BY 
    s.statistics_rush_yds DESC;
#5
DELIMITER //


CREATE TRIGGER check_salary_cap
BEFORE INSERT ON player
FOR EACH ROW
BEGIN
    DECLARE salary_cap INT;
    DECLARE hardcode_nfl_cap INT;
    SET hardcode_nfl_cap = 224800000;


    SELECT player_salary INTO salary_cap
    FROM player
    WHERE team_id = NEW.team_id;


    IF New.player_salary + salary_cap > hardcode_nfl_cap THEN
   	 SIGNAL SQLSTATE '45000'
   	 SET MESSAGE_TEXT = 'Player salary causes team to exceed NFL salary cap';
   	 /*INSERT INTO non_existing_table (non_existing_column) VALUES ('INVALID Value: Player salary exceeds salary cap');*/
    END IF;
END;
//


DELIMITER ;


INSERT INTO player (player_first_name, player_last_name, player_salary, team_id)
VALUES ('Bob', 'Alice', 300000000, 1);

#6

DELIMITER //


CREATE TRIGGER remove_player_injury
AFTER DELETE ON player
FOR EACH ROW
BEGIN
    DELETE FROM injury
    WHERE player_id = OLD.player_id;
END;
//


DELIMITER ;


INSERT INTO injury (injury_description, injury_status, injury_return_date, player_id)
VALUES ('Sprained Ankle', 'Active', '2023-11-30 10:00:00', 1); --Dak Presscott


DELETE FROM player
WHERE player_id = 1;

#7.1

SELECT team_name AS Team, game_id AS "Games Played", PointsScored AS "Total Points Scored"
FROM (Select team_name,game_id, teamgame_points_scored AS PointsScored
	  From (SELECT team_name, team_id as ID  
			FROM team
			WHERE team_name = "Dallas Cowboys") as GetID
	  INNER JOIN teamgame
	  ON GetID.ID = teamgame.team_id
) AS O;

#7.2

SELECT avg(player_salary) as "Average Quarterback Salary"
 From (SELECT player_id as PID
			FROM (SELECT positions_ID as ID
				  FROM positions					
                  WHERE positions_name = "Quarterback" ) as PositionID
      	   INNER JOIN playerpositions
	  ON PositionID.ID = playerpositions.positions_id
) as T
INNER JOIN player
ON T.PID = player_id;





