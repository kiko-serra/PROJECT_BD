.mode columns
.headers on
.nullvalue NULL

--List each Match with both Players id's and their Fide title.

CREATE VIEW IF NOT EXISTS titlePlayer AS
    SELECT title, id_player 
    FROM Player JOIN FideRanking USING(id_player);

CREATE VIEW IF NOT EXISTS matchIndex AS
    SELECT id_match, id_player, title
    FROM PlayerMatch JOIN titlePlayer USING(id_player);

SELECT P1.id_match AS matchID, P1.id_player AS player1, P1.title AS titleP1, P2.id_player AS player2, P2.title AS titleP2
FROM matchIndex P1, matchIndex P2
WHERE P1.id_match = P2.id_match AND P1.id_player <  P2.id_player
ORDER BY matchID;

DROP VIEW titlePlayer;
DROP VIEW matchIndex;