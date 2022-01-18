.mode columns
.headers on
.nullvalue NULL

-- Listagem de número de partidas de cada player versão 2

SELECT id_player, count(*) as numeroDeJogos
FROM PlayerMatch inner join Match
ON PlayerMatch.id_match = Match.id_match
GROUP BY id_player; 