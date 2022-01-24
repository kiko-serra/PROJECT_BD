.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;
Select * from FideRanking;

INSERT INTO Player VALUES (48474,"Dana","Phillips","578 Quai de Nesle, Apt. 109, 92646, Le Mans, Bretagne, France","(452) 261-4753",'1983-12-13');
INSERT INTO FideRanking VALUES (48474,48474,"MEN","International Master (IM)",2400);

Select * from FideRanking;

INSERT INTO Player VALUES (2,"Dana","Phillips","578 Quai de Nesle, Apt. 109, 92646, Le Mans, Bretagne, France","(452) 251-4753",'2020-12-13');
INSERT INTO FideRanking VALUES (2,2,"MEN","International Master (IM)",2400);

Select * from FideRanking;