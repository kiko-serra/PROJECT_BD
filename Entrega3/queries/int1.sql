.mode columns
.headers on
.nullvalue NULL

-- Difference between points from Players and the tournament´s average

CREATE VIEW IF NOT EXISTS randomIdTournament AS
    SELECT id_tournament
    FROM Tournament
    LIMIT 1 OFFSET (ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM Tournament), 1));

CREATE VIEW IF NOT EXISTS allPlayersInTournament AS
    SELECT id_player
    FROM PlayerTournament, randomIdTournament
    WHERE PlayerTournament.id_tournament = randomIdTournament.id_tournament;

CREATE VIEW IF NOT EXISTS playersRanking AS
    SELECT first_name, last_name, number_of_elo_points
    FROM Player, allPlayersInTournament, FideRanking
    WHERE allPlayersInTournament.id_player = FideRanking.id_player AND Player.id_player = allPlayersInTournament.id_player;

CREATE VIEW IF NOT EXISTS average AS
    SELECT ROUND(AVG(number_of_elo_points),0) AS average
    FROM playersRanking;

SELECT first_name AS firstName, last_name AS lastName , number_of_elo_points AS numberOfEloPoints, number_of_elo_points - average AS deviationFromTheAverage
FROM playersRanking, average
ORDER BY deviationFromTheAverage DESC;

DROP VIEW randomIdTournament;
DROP VIEW allPlayersInTournament;
DROP VIEW playersRanking;
DROP VIEW average;