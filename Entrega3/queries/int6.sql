.mode columns
.headers on
.nullvalue NULL

--List of the addresses from all the Chessclubs and Sponsors

SELECT address FROM ChessClub

UNION 

SELECT address FROM Sponsor