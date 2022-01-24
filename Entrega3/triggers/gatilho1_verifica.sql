.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Initial state for Players:'
.print ''

Select * from player;

.print ''
.print 'Trying to insert Player with phone number valid...'
.print ''

INSERT INTO Player VALUES (10000000,"dc","Hewey","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","(123) 321-1234",'1999-10-09');

.print ''
.print 'Inserted with sucess:'
.print ''

Select * from player;

.print ''
.print 'Trying to insert Player with phone number invalid...'
.print ''

INSERT INTO Player VALUES (10000001,"Ole","Hey","4280 Impasse de l'Odéon, Apt. 934, 57468, Le Mans, Lorraine, France","932098275",'1999-10-09');

.print ''
.print 'Not inserted due to trigger (as showned below):'
.print ''

Select * from player;