.mode columns
.headers on
.nullvalue NULL

-- Mostra o clube com o pior ranking.

SELECT MIN(ranking) as PointsWorstClub, name as ClubName
FROM ChessClub;