.mode columns
.headers on
.nullvalue NULL

-- List Player and Tournament Id's and Type of Sponsor when one sponsor from the player who won the tournament is the same as at least one of the tournaments sponsors.
CREATE VIEW IF NOT EXISTS tournamentWinner as
    Select *
    from (PlayerTournament inner join LevelOfSponsorPlayer on PlayerTournament.id_player = LevelOfSponsorPlayer.id_player)
    where winner = '1';

CREATE VIEW IF NOT EXISTS tournamentWinnerAll as
    Select tournamentWinner.id_player as id_player, tournamentWinner.type as typePlayer, tournamentWinner.id_tournament as id_tournament, LevelOfSponsorTournament.type as typeTournament
    from tournamentWinner inner join LevelOfSponsorTournament
    on tournamentWinner.id_tournament = LevelOfSponsorTournament.id_tournament;
    
SELECT id_player, id_tournament, typePlayer
FROM tournamentWinnerAll
where typePlayer=typeTournament
GROUP BY id_player;

DROP VIEW tournamentWinner;
DROP VIEW tournamentWinnerAll;