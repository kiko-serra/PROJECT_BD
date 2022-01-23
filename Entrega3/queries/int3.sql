.mode columns
.headers on
.nullvalue NULL

--List each Match with both Players id's and their Fide title.

CREATE VIEW IF NOT EXISTS TitlePlayer as
    SELECT title, id_player 
    FROM Player join FideRanking using(id_player);

CREATE VIEW IF NOT EXISTS MatchIndex as
    SELECT id_match, id_player, title
    FROM PlayerMatch join TitlePlayer using(id_player);

SELECT P1.id_match as id_match, P1.id_player as player1, P1.title as title_p1, P2.id_player as player2, P2.title as title_p2
FROM MatchIndex P1, MatchIndex P2
WHERE P1.id_match = P2.id_match and P1.id_player <  P2.id_player
Order by id_match;

DROP VIEW TitlePlayer;
DROP VIEW MatchIndex;