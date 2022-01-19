.mode columns
.headers on
.nullvalue NULL

CREATE VIEW if not EXISTS playersInTournaments as
    SELECT first_name, last_name, winner
    FROM Player inner join PlayerTournament
    ON Player.id_player = PlayerTournament.id_player;


SELECT first_name, last_name
FROM playersInTournaments

EXCEPT

SELECT first_name, last_name
FROM playersInTournaments
WHERE winner = 1
ORDER BY first_name, last_name;

DROP VIEW playersInTournaments;
