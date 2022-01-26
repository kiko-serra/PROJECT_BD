.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--One player that is more than 20 years old and inserted as "JUNIORS" or "GIRLS" will be changed into "MEN" or "WOMEN" and vice-versa.

CREATE TRIGGER IF NOT EXISTS WrongCategoryAdults 
    AFTER INSERT ON FideRanking
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player WHERE id_player = NEW.id_player) >= 12000.0 
    BEGIN
        UPDATE FideRanking SET category = "MEN" WHERE NEW.category = "JUNIORS" AND id_player = NEW.id_player;
        UPDATE FideRanking SET category = "WOMEN" WHERE NEW.category = "GIRLS" AND id_player = NEW.id_player;
    END;

CREATE TRIGGER IF NOT EXISTS WrongCategoryChilds 
    AFTER INSERT ON FideRanking
    WHEN (SELECT julianday('now') - julianday(birthday) FROM Player WHERE id_player = NEW.id_player) < 12000.0
    BEGIN
        UPDATE FideRanking SET category = "JUNIORS" WHERE NEW.category = "MEN" AND id_player = NEW.id_player;
        UPDATE FideRanking SET category = "GIRLS" WHERE NEW.category = "WOMEN" AND id_player = NEW.id_player;
    END;
