.mode columns
.headers on
.nullvalue NULL

--List all names and addresses from ChessClubs with "Pawn" in name and all names and addresses from Sponsors with "Crop" in name and "77" in address.

SELECT name, address 
FROM ChessClub
WHERE name LIKE '%Pawn%'

UNION

SELECT name, address 
FROM Sponsor
WHERE name LIKE '%Corp%'
AND address LIKE '%77%';