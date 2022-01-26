.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--Checks if a phone number is valid. Prints an error if its invalid.

CREATE TRIGGER phone_numberValid
   BEFORE INSERT ON Player
BEGIN
   SELECT
      CASE
	WHEN NEW.phone_number NOT LIKE '(___) ___-____' THEN
   	  RAISE (ABORT,'Invalid phone number ')
       END;
END;