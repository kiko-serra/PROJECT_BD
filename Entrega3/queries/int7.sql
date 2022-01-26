.mode columns
.headers on
.nullvalue NULL

--List of all the players that played in any tournament but did not win it.

CREATE VIEW IF NOT EXISTS playersInTournaments AS
    SELECT Player.id_player, first_name, last_name, winner
    FROM Player INNER JOIN PlayerTournament
    ON Player.id_player = PlayerTournament.id_player;


SELECT id_player AS playerID, first_name AS firstName, last_name AS lastName
FROM playersInTournaments

EXCEPT

SELECT id_player, first_name, last_name
FROM playersInTournaments
WHERE winner = 1
ORDER BY playerID;

DROP VIEW playersInTournaments;
