.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--first .read criar.sql second .read triggers and last .read povoar.sql

CREATE TRIGGER validateEmail
   BEFORE INSERT ON Account
BEGIN
   SELECT
      CASE
	WHEN NEW.email NOT LIKE '%_@__%.__%' THEN
   	  RAISE (ABORT,'Invalid email address')
       END;
END;