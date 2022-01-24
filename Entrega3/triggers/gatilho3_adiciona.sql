.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

CREATE TRIGGER IF NOT EXISTS WrongCategoryAdults 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT birthday FROM Player WHERE julianday('now') - julianday(birthday)) >= 12000.0
    BEGIN
        UPDATE FideRanking SET category = "MEN" WHERE category = "JUNIORS";
        UPDATE FideRanking SET category = "WOMEN" WHERE category = "GIRLS";
    END;

CREATE TRIGGER IF NOT EXISTS WrongCategoryChilds 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT birthday FROM Player WHERE julianday('now') - julianday(birthday)) < 12000.0
    BEGIN
        UPDATE FideRanking SET category = "JUNIORS" WHERE category = "MEN";
        UPDATE FideRanking SET category = "GIRLS" WHERE category = "WOMEN";
    END;