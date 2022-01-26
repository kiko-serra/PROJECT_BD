.mode columns
.headers on
.nullvalue NULL

-- Club with the worst ranking

SELECT name AS clubName, MIN(ranking) AS pointsWorstClub
FROM ChessClub;