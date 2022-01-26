.mode columns
.headers on
.nullvalue NULL

--Nickname of the account from the Player with the most elo points 

CREATE VIEW IF NOT EXISTS accountName AS
    SELECT Player.id_player, Account.nickname
    FROM Player INNER JOIN Account
    ON Player.id_player = Account.id_player
    GROUP BY Player.id_player;

CREATE VIEW IF NOT EXISTS maxElo AS
    SELECT Player.id_player, FideRanking.number_of_elo_points AS number
    FROM Player INNER JOIN FideRanking
    ON Player.id_player = FideRanking.id_player;

SELECT maxElo.id_player AS playerID, MAX(maxElo.number) AS numberOfPoints, accountName.nickname AS nickname
FROM maxElo INNER JOIN accountName
ON maxElo.id_player = accountName.id_player;

DROP VIEW accountName;
DROP VIEW maxElo;