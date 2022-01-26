.mode columns
.headers on
.nullvalue NULL

-- List of all players that have not played any game yet.

SELECT id_player AS playerID, first_name AS firstName, last_name AS lastName 
FROM Player
WHERE id_player NOT IN (SELECT id_player FROM PlayerMatch)
ORDER BY playerID;
