.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Initial state for FideRanking:'
.print ''

SELECT * FROM FideRanking WHERE id_player < 6;

.print ''
.print 'Trying to insert a Player (id_player=1) with more than 20 years and category as MEN...'
.print ''

INSERT INTO Player VALUES (1,"Dana","Phillips","578 Quai de Nesle","(452) 211-4753",'1983-12-13');
INSERT INTO FideRanking VALUES (1,1,"MEN","Fide Master (FM)",2900);

.print ''
.print 'Inserted with sucess (no changes required):'
.print ''

SELECT * FROM FideRanking WHERE id_player < 6;

.print ''
.print 'Trying to insert a Player (id_player=2) with more than 20 years and category as GIRLS...'
.print ''

INSERT INTO Player VALUES (2,"Diana","Princess","578 Quai","(412) 921-4753",'1960-12-13');
INSERT INTO FideRanking VALUES (2,2,"GIRLS","Grand Master (GM)",1500);

.print ''
.print 'Inserted with sucess (changes required):'
.print ''

SELECT * FROM FideRanking WHERE id_player < 6;

.print ''
.print 'Trying to insert a Player (id_player=3) with less than 20 years and category as MEN...'
.print ''

INSERT INTO Player VALUES (3,"Hey","Jones","578 Quai de","(453) 251-4753",'2020-12-13');
INSERT INTO FideRanking VALUES (3,3,"MEN","International Master (IM)",2400);

.print ''
.print 'Inserted with sucess (changes required):'
.print ''

SELECT * FROM FideRanking WHERE id_player < 6;

.print ''
.print 'Trying to insert a Player (id_player=4) with less than 20 years and category as WOMEN...'
.print ''

INSERT INTO Player VALUES (4,"Queen","K","578 Quai de","(452) 251-4742",'2020-12-13');
INSERT INTO FideRanking VALUES (4,4,"WOMEN",NULL,600);

.print ''
.print 'Inserted with sucess (changes required):'
.print ''

SELECT * FROM FideRanking WHERE id_player < 6;

.print ''
.print 'Trying to insert a Player (id_player=5) with more than 20 years and category as WOMEN...'
.print ''

INSERT INTO Player VALUES (5,"Lady","M","9630 Quai from all over","(452) 151-4715",'1970-05-26');
INSERT INTO FideRanking VALUES (5,5,"WOMEN",NULL,423);

.print ''
.print 'Inserted with sucess (no changes required):'
.print ''

SELECT * FROM FideRanking WHERE id_player < 6;
