.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;



CREATE TRIGGER IF NOT EXISTS WrongCategoryAdultsMen 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player) >= 12000.0 
    BEGIN
        UPDATE FideRanking SET category = "MEN" WHERE NEW.category = "JUNIORS";
    END;

CREATE TRIGGER IF NOT EXISTS WrongCategoryChildsJun 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player) < 12000.0
    BEGIN
        UPDATE FideRanking SET category = "JUNIORS" WHERE NEW.category = "MEN";
    END;

CREATE TRIGGER IF NOT EXISTS WrongCategoryAdultsWom 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player) >= 12000.0 
    BEGIN
        UPDATE FideRanking SET category = "WOMEN" WHERE NEW.category = "GIRLS";
    END;

CREATE TRIGGER IF NOT EXISTS WrongCategoryChildsGir 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player) < 12000.0
    BEGIN
        UPDATE FideRanking SET category = "GIRLS" WHERE NEW.category = "WOMEN";
    END;