.mode columns
.headers on
.nullvalue NULL

--tentativa de dizer o numero de jogos do jogador com mais elo points e usar select dentro de select

SELECT id_player, MAX(number_of_elo_points) as GreatestPlayer, (SELECT count(*) from Player natural join PlayerMatch where Player.id_player = PlayerMatch.id_player) as numberOfMatches
FROM FideRanking;
