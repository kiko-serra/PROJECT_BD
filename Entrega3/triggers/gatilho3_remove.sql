.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS WrongCategoryAdultsMen;
DROP TRIGGER IF EXISTS WrongCategoryAdultsWom;

DROP TRIGGER IF EXISTS WrongCategoryChildsJun; 
DROP TRIGGER IF EXISTS WrongCategoryChildsGir; 