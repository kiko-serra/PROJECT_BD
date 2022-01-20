.mode columns
.headers on
.nullvalue NULL

-- List of all players that have not play any game yet.

SELECT first_name, last_name 
FROM Player
WHERE id_player NOT IN (SELECT id_player FROM PlayerMatch)
ORDER BY first_name, last_name;