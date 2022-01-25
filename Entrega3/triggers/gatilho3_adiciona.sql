.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;



CREATE TRIGGER IF NOT EXISTS WrongCategoryAdults 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player) >= 12000.0 
    BEGIN
        UPDATE FideRanking SET category = "MEN" WHERE NEW.category = "JUNIORS" and id_player = NEW.id_player;
        UPDATE FideRanking SET category = "WOMEN" WHERE NEW.category = "GIRLS" and id_player = NEW.id_player;
    END;

CREATE TRIGGER IF NOT EXISTS WrongCategoryChilds 
    AFTER INSERT ON FideRanking
    FOR EACH ROW
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player) < 12000.0
    BEGIN
        UPDATE FideRanking SET category = "JUNIORS" WHERE NEW.category = "MEN" and id_player = NEW.id_player;
        UPDATE FideRanking SET category = "GIRLS" WHERE NEW.category = "WOMEN" and id_player = NEW.id_player;
    END;
