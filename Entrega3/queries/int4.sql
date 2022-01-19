.mode columns
.headers on
.nullvalue NULL

-- Number of matches in a tournament.

SELECT name, COUNT(id_match) as numberOfMatches
FROM Tournament, Match
WHERE Tournament.id_tournament = Match.id_tournament
GROUP BY name