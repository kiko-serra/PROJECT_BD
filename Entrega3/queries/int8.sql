.mode columns
.headers on
.nullvalue NULL

-- List the 3 accounts with the most points from a Website that as already created at least one Match

SELECT id_account AS accountID, nickname, number_of_points AS numberOfPoints, id_website AS websiteID
FROM Account
WHERE id_website IN (SELECT Website.id_website 
                    FROM Website, Match 
                    WHERE Website.id_website = Match.id_website) 
                    ORDER BY numberOfPoints DESC LIMIT 3;
 
