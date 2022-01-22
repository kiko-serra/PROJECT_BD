.mode columns
.headers on
.nullvalue NULL

-- A diferença de pontos dos jogadores e a média num torneio aleatório.
CREATE VIEW IF NOT EXISTS randomIdTournament as
    SELECT id_tournament
    FROM Tournament
    LIMIT 1 OFFSET (ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM Tournament), 1));

CREATE VIEW IF NOT EXISTS allPlayersInTournament as
    SELECT id_player
    FROM PlayerTournament, randomIdTournament
    WHERE PlayerTournament.id_tournament = randomIdTournament.id_tournament;

Create VIEW IF NOT EXISTS playersRanking as
    SELECT first_name, last_name, number_of_elo_points
    FROM Player, allPlayersInTournament, FideRanking
    WHERE allPlayersInTournament.id_player = FideRanking.id_player and Player.id_player = allPlayersInTournament.id_player;

Create VIEW IF NOT EXISTS average as
    SELECT round(AVG(number_of_elo_points),0) as average
    FROM playersRanking;

SELECT first_name, last_name, number_of_elo_points, number_of_elo_points-average as average_of_fide_points
FROM playersRanking, average
ORDER BY average_of_fide_points desc;

DROP VIEW randomIdTournament;
DROP VIEW allPlayersInTournament;
DROP VIEW playersRanking;
DROP VIEW average;