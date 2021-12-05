PRAGMA foreign_keys = on;

BEGIN TRANSACTION;

-- Table: Player
DROP TABLE IF EXISTS Player;

CREATE TABLE Player (
    id_player INTEGER PRIMARY KEY,
    first_name TEXT CONSTRAINT null_Player_firstName NOT NULL,
    last_name TEXT CONSTRAINT null_Player_lastName NOT NULL,
    adress TEXT CONSTRAINT unique_Player_adress UNIQUE,
    phone_number INTEGER CONSTRAINT unique_Player_phoneNumber UNIQUE,
    birthday DATE CONSTRAINT null_Player_birthday NOT NULL
);

-- Table: Match
DROP TABLE IF EXISTS Match;

CREATE TABLE Match (
    id_match INTEGER PRIMARY KEY,
    --CHECK AGAIN
    result INTEGER REFERENCES Player,
    --------------------------------
    details TEXT,
    date DATE CONSTRAINT null_Match_date NOT NULL,
    duration_white TIME CONSTRAINT null_Match_durationWhite NOT NULL,
    duration_black TIME CONSTRAINT null_Match_durationBlack NOT NULL,
    increment INTEGER CONSTRAINT null_Match_increment NOT NULL,
    number_of_moves INTEGER CONSTRAINT null_Match_numberOfMoves NOT NULL,
    id_tournament INTEGER REFERENCES Tournament,
    id_website INTEGER REFERENCES Website
);

-- Table: Account
DROP TABLE IF EXISTS Account;

CREATE TABLE Account (
    id_account INTEGER PRIMARY KEY,
    nickname TEXT CONSTRAINT unique_Account_nickname UNIQUE CONSTRAINT null_Account_nickname NOT NULL,
    email TEXT CONSTRAINT unique_Account_email UNIQUE CONSTRAINT null_Account_email NOT NULL,
    title TEXT,
    number_of_points INTEGER CONSTRAINT zero_Account_numberOfPoints CHECK(number_of_points >= 0),
    id_website INTEGER REFERENCES Website
);

-- Table: Tournament
DROP TABLE IF EXISTS Tournament;

CREATE TABLE Tournament (
    id_tournament INTEGER PRIMARY KEY,
    start_date DATE CONSTRAINT null_Tournament_startDate NOT NULL,
    end_date DATE CONSTRAINT null_Tournament_endDate NOT NULL,
    name TEXT CONSTRAINT null_Tournament_name NOT NULL,
    --CHECK AGAIN
    winner INTEGER REFERENCES Player,
    --------------------------------
    id_website INTEGER REFERENCES Website
);

-- Table: PlayerSponsor
DROP TABLE IF EXISTS PlayerSponsor;

CREATE TABLE PlayerSponsor (
    id_player INTEGER REFERENCES Player,
    id_sponsor INTEGER REFERENCES Sponsor,
    PRIMARY KEY(id_player, id_sponsor)
);

-- Table: PlayerTournament
DROP TABLE IF EXISTS PlayerTournament;

CREATE TABLE PlayerTournament (
    id_player INTEGER REFERENCES Player,
    id_tournament INTEGER REFERENCES Tournament,
    PRIMARY KEY(id_player, id_tournament)
);

-- Table: PlayerMatch
DROP TABLE IF EXISTS PlayerMatch;

CREATE TABLE PlayerMatch (
    id_player INTEGER REFERENCES Player,
    id_match INTEGER REFERENCES Match,
    PRIMARY KEY(id_player, id_match)
);

-- Table: PlayerAccount
DROP TABLE IF EXISTS PlayerAccount;

CREATE TABLE PlayerAccount (
    id_player INTEGER REFERENCES Player,
    id_account INTEGER REFERENCES Account,
    PRIMARY KEY(id_player, id_account)
);

-- Table: MatchChessClub
DROP TABLE IF EXISTS MatchChessClub;

CREATE TABLE MatchChessClub (
    id_match INTEGER REFERENCES Match,
    id_club INTEGER REFERENCES ChessClub,
    PRIMARY KEY(id_match, id_club)
);

-- Table: TournamentChessClub
DROP TABLE IF EXISTS TournamentChessClub;

CREATE TABLE TournamentChessClub (
    id_tournament INTEGER REFERENCES Tournament,
    id_club INTEGER REFERENCES ChessClub,
    PRIMARY KEY(id_tournament, id_club)
);

-- Table: TournamentSponsor
DROP TABLE IF EXISTS TournamentSponsor;

CREATE TABLE TournamentSponsor (
    id_tournament INTEGER REFERENCES Tournament,
    id_sponsor INTEGER REFERENCES Sponsor,
    PRIMARY KEY(id_tournament, id_sponsor)
);

-- CONTINUAR AQUI
COMMIT TRANSACTION;

PRAGMA foreign_keys = on;