.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

INSERT INTO ChessClub VALUES (1500009,"May the Fork be with Us","N960-8 62, Bloco 52, 1706-151, Lamego, Santarém, Portuguese",821,0);

.print ''
.print 'Initial number of members:'
.print ''

SELECT name, number_of_members FROM ChessClub WHERE id_club = 1500009;

.print ''
.print 'Trying to insert Player with a club associated...'
.print ''

INSERT INTO Player VALUES (10000000,"Hey","Bases","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","(123) 321-1234",'1999-10-09');
INSERT INTO MemberId VALUES (1500009, 10000000, 10000000);

.print ''
.print 'Inserted with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_club = 1500009;

.print ''
.print 'Trying to insert Player with a club associated...'
.print ''

INSERT INTO Player VALUES (10000001,"Do","de","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","(124) 321-1234",'1999-10-09');
INSERT INTO MemberId VALUES (1500009, 10000001, 10000001);

.print 'Inserted with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_club = 1500009;

.print ''
.print 'Trying to insert Player with a club associated...'
.print ''

INSERT INTO Player VALUES (10000002,"You","Muitos","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","(125) 321-1234",'1999-10-09');
INSERT INTO MemberId VALUES (1500009, 10000002, 10000002);

.print ''
.print 'Inserted with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_club = 1500009;

.print ''
.print 'Trying to insert Player with a club associated...'
.print ''

INSERT INTO Player VALUES (10000003,"Like","Dados","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","(126) 321-1234",'1999-10-09');
INSERT INTO MemberId VALUES (1500009, 10000003, 10000003);

.print ''
.print 'Inserted with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_club = 1500009;

.print ''
.print 'Final number of members:'
.print ''

SELECT name, number_of_members FROM ChessClub WHERE id_club = 1500009;

.print ''
.print 'Trying to remove a Player with a club associated...'
.print ''

DELETE FROM MemberId WHERE id_player = 10000000;
DELETE FROM Player WHERE id_player = 10000000;

.print ''
.print 'Remove with sucess:'
.print ''

SELECT * FROM MemberId WHERE id_club = 1500009;

.print ''
.print 'Final number of members:'
.print ''

SELECT name, number_of_members FROM ChessClub WHERE id_club = 1500009;

.print ''
.print 'Deleting enough members for the club to be deleted (less than 3 members):'
.print ''

DELETE FROM MemberId WHERE member_id = 10000001;
DELETE FROM MemberId WHERE member_id = 10000002;
SELECT name, number_of_members FROM ChessClub WHERE id_club = 1500009;

.print ''
.print 'Club deleted with sucess :D'
.print ''