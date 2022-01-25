.mode columns
.headers on
.nullvalue NULL

--List of the number of matches played by each player who has played at least 3 matches.

SELECT Player.id_player, Player.first_name AS FirstName, COUNT(*) AS NumberOfMatches 
FROM Player INNER JOIN PlayerMatch
ON Player.id_player = PlayerMatch.id_player
GROUP BY Player.id_player 
HAVING COUNT(Player.id_player)>=3;