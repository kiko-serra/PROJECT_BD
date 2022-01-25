.mode columns
.headers on
.nullvalue NULL

-- List all players names and nicknames from a random website where they have an account.

CREATE VIEW IF NOT EXISTS nicknamePlayer AS
    SELECT nickname ,first_name, last_name, id_website
    FROM Player JOIN Account
    WHERE Player.id_player=Account.id_player;

CREATE VIEW IF NOT EXISTS randomIdWebsite AS
    SELECT id_website, name
    FROM Website
    LIMIT 1 OFFSET (ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM Website), 1));
    
SELECT nickname, first_name, last_name, name AS Website_name
FROM nicknamePlayer, randomIdWebsite
WHERE nicknamePlayer.id_website=randomIdWebsite.id_website
ORDER BY nickname ASC LIMIT 10;


DROP VIEW nicknamePlayer;
DROP VIEW randomIdWebsite;