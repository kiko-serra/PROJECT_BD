.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;
Select * from FideRanking;

INSERT INTO Player VALUES (48474,"Dana","Phillips","578 Quai de Nesle","(452) 261-4753",'1983-12-13');
INSERT INTO FideRanking VALUES (48474,48474,"MEN","International Master (IM)",2400);

Select * from FideRanking;

INSERT INTO Player VALUES (5,"Diana","Princess","578 Quai","(452) 921-4753",'1960-12-13');
INSERT INTO FideRanking VALUES (5,5,"GIRLS","Grand Master (IM)",500);

Select * from FideRanking;

INSERT INTO Player VALUES (2,"Hey","Jones","578 Quai de","(452) 251-4753",'2020-12-13');
INSERT INTO FideRanking VALUES (2,2,"MEN","International Master (IM)",2400);

Select * from FideRanking;

INSERT INTO Player VALUES (6,"Queen","K","578 Quai de","(452) 251-4752",'2020-12-13');
INSERT INTO FideRanking VALUES (6,6,"WOMEN","Grandeee Master (IM)",600);

Select * from FideRanking;
