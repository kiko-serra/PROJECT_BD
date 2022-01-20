.mode columns
.headers on
.nullvalue NULL

-- List the 3 accounts with the most points from a Website that as already created at least one Match

SELECT id_account, number_of_points, id_website
FROM Account
WHERE id_website IN (SELECT Website.id_website 
                    from Website, Match 
                    where website.id_website = match.id_website 
                    Order by number_of_points desc limit 3);
 
