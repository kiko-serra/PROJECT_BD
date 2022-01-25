.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Initial number of members:'
.print ''

SELECT name, number_of_members FROM ChessClub WHERE id_club = 37879;

.print ''
.print 'Trying to insert Player with a club associated...'
.print ''

INSERT INTO Player VALUES (10000000,"dc","Hewey","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","(123) 321-1234",'1999-10-09');
INSERT INTO MemberId (id_club, id_player, member_id) VALUES (37879, 10000000, 10000000);

.print 'Inserted with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_player = 10000000;

.print ''
.print 'Final number of members:'
.print ''

SELECT name, number_of_members FROM ChessClub WHERE id_club = 37879;

.print ''
.print 'Trying to remove a Player with a club associated...'
.print ''

DELETE FROM MemberId WHERE id_player = 10000000;
DELETE FROM Player WHERE id_player = 10000000;

.print ''
.print 'Remove with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_player = 10000000;

.print ''
.print 'Final number of members:'
.print ''

SELECT name, number_of_members FROM ChessClub WHERE id_club = 37879;