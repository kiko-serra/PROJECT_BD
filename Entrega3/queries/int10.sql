.mode columns
.headers on
.nullvalue NULL

-- Club with the worst ranking

SELECT MIN(ranking) AS PointsWorstClub, name AS ClubName
FROM ChessClub;