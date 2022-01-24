.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--first .read criar.sql second .read triggers and last .read povoar.sql

CREATE TRIGGER phone_numberValid
   BEFORE INSERT ON Player
BEGIN
   SELECT
      CASE
	WHEN NEW.phone_number NOT LIKE '(___) ___-____' THEN
   	  RAISE (ABORT,'Invalid phone number ')
       END;
END;