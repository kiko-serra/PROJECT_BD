.mode columns
.headers on
.nullvalue NULL

--List of the number of matches played by each player who has played at least 3 matches.

SELECT Player.id_player AS playerID, Player.first_name AS firstName, Player.last_name AS lastName , COUNT(*) AS numberOfMatches 
FROM Player INNER JOIN PlayerMatch
ON Player.id_player = PlayerMatch.id_player
GROUP BY Player.id_player 
HAVING COUNT(Player.id_player)>=3;