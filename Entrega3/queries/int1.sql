.mode columns
.headers on
.nullvalue NULL 

SELECT id_player, MAX(number_of_elo_points) as GreatestPlayer
FROM FideRanking
