.mode columns
.headers on
.nullvalue NULL

--List of the number of matches played by each player who has played at least 3 matches.

SELECT Player.id_player, Player.first_name as FirstName, count(*) AS NumberOfMatches 
FROM Player inner join PlayerMatch
ON Player.id_player = PlayerMatch.id_player
GROUP BY Player.id_player 
HAVING count(Player.id_player)>=3;