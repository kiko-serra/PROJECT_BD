.mode columns
.headers on
.nullvalue NULL

-- List Player and Tournament Id's and Type of Sponsor when one sponsor from the player who won the tournament is the same as at least one of the tournaments sponsors.
CREATE VIEW IF NOT EXISTS tournamentWinner AS
    SELECT *
    FROM (PlayerTournament INNER JOIN LevelOfSponsorPlayer ON PlayerTournament.id_player = LevelOfSponsorPlayer.id_player)
    WHERE winner = '1';

CREATE VIEW IF NOT EXISTS tournamentWinnerAll AS
    SELECT tournamentWinner.id_player AS id_player, tournamentWinner.type AS typePlayer, tournamentWinner.id_tournament AS id_tournament, LevelOfSponsorTournament.type AS typeTournament
    FROM tournamentWinner INNER JOIN LevelOfSponsorTournament
    ON tournamentWinner.id_tournament = LevelOfSponsorTournament.id_tournament;
    
SELECT id_player, id_tournament, typePlayer
FROM tournamentWinnerAll
WHERE typePlayer=typeTournament
GROUP BY id_player;

DROP VIEW tournamentWinner;
DROP VIEW tournamentWinnerAll;