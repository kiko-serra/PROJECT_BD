.mode columns
.headers on
.nullvalue NULL

--nickname da account do player com mais elo points 
-- autoria: Francisco o deus e nao o um 
CREATE VIEW if not EXISTS accountName as
    SELECT Player.id_player, Account.nickname
    FROM Player inner join Account
    ON Player.id_player = Account.id_player
    GROUP BY Player.id_player;

CREATE VIEW if not EXISTS maxElo as
    SELECT Player.id_player, FideRanking.number_of_elo_points as number
    FROM Player inner join FideRanking
    ON Player.id_player = FideRanking.id_player;

SELECT maxElo.id_player as Player_ID, MAX(maxElo.number) as GreatestPlayer, accountName.nickname as NickName
FROM maxElo inner join accountName
ON maxElo.id_player = accountName.id_player;

DROP VIEW accountName;
DROP VIEW maxElo;