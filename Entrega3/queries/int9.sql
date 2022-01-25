.mode columns
.headers on
.nullvalue NULL

--nickname da account do player com mais elo points 

CREATE VIEW IF NOT EXISTS accountName AS
    SELECT Player.id_player, Account.nickname
    FROM Player INNER JOIN Account
    ON Player.id_player = Account.id_player
    GROUP BY Player.id_player;

CREATE VIEW IF NOT EXISTS maxElo AS
    SELECT Player.id_player, FideRanking.number_of_elo_points AS number
    FROM Player INNER JOIN FideRanking
    ON Player.id_player = FideRanking.id_player;

SELECT maxElo.id_player AS Player_ID, MAX(maxElo.number) AS NumberOfPoints, accountName.nickname AS NickName
FROM maxElo INNER JOIN accountName
ON maxElo.id_player = accountName.id_player;

DROP VIEW accountName;
DROP VIEW maxElo;