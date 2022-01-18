.mode columns
.headers on
.nullvalue NULL

-- Listagem de número de partidas de cada player

SELECT id_player, first_name, last_name, count(*) AS numeroDePartidas 
FROM Player natural join PlayerMatch
Where Player.id_player = PlayerMatch.id_player
GROUP BY id_player, first_name, last_name;