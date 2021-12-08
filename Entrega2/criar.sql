PRAGMA foreign_keys = on;

BEGIN TRANSACTION;

-- Table: Player
DROP TABLE IF EXISTS Player;

CREATE TABLE Player (
    id_player INTEGER PRIMARY KEY,
    first_name TEXT CONSTRAINT null_Player_firstName NOT NULL,
    last_name TEXT CONSTRAINT null_Player_lastName NOT NULL,
    adress TEXT CONSTRAINT unique_Player_adress UNIQUE,
    phone_number TEXT CONSTRAINT unique_Player_phoneNumber UNIQUE,
    birthday DATE CONSTRAINT null_Player_birthday NOT NULL
);

-- Table: FideRanking
DROP TABLE IF EXISTS FideRanking;

CREATE TABLE FideRanking (
    id_player INTEGER PRIMARY KEY REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    category TEXT CONSTRAINT null_FideRanking_category NOT NULL CONSTRAINT check_FideRanking_category CHECK (
        (
            category = "MEN"
            OR category = "WOMEN"
            OR category = "JUNIORS"
            OR category = "GIRLS"
        )
    ),
    title TEXT,
    number_of_elo_points INTEGER CONSTRAINT zero_FideRanking_numberOfEloPoints CHECK(number_of_elo_points >= 0)
);

-- Table: Website
DROP TABLE IF EXISTS Website;

CREATE TABLE Website (
    id_website INTEGER PRIMARY KEY,
    link TEXT CONSTRAINT null_Website_link NOT NULL CONSTRAINT unique_Website_link UNIQUE,
    name TEXT CONSTRAINT null_Website_name NOT NULL CONSTRAINT unique_Website_name UNIQUE
);

-- Table: Account
DROP TABLE IF EXISTS Account;

CREATE TABLE Account (
    id_account INTEGER PRIMARY KEY,
    nickname TEXT CONSTRAINT unique_Account_nickname UNIQUE CONSTRAINT null_Account_nickname NOT NULL,
    email TEXT CONSTRAINT unique_Account_email UNIQUE CONSTRAINT null_Account_email NOT NULL,
    title TEXT,
    number_of_points INTEGER CONSTRAINT zero_Account_numberOfPoints CHECK(number_of_points >= 0),
    id_website INTEGER REFERENCES WebsiteON ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: Tournament
DROP TABLE IF EXISTS Tournament;

CREATE TABLE Tournament (
    id_tournament INTEGER PRIMARY KEY,
    start_date DATE CONSTRAINT null_Tournament_startDate NOT NULL,
    end_date DATE CONSTRAINT null_Tournament_endDate NOT NULL,
    name TEXT CONSTRAINT null_Tournament_name NOT NULL,
    --CHECK AGAIN
    winner INTEGER REFERENCES Player ON ON DELETE CASCADE ON UPDATE CASCADE,
    --------------------------------
    id_website INTEGER REFERENCES WebsiteON ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: Match
DROP TABLE IF EXISTS Match;

CREATE TABLE Match (
    id_match INTEGER PRIMARY KEY,
    --CHECK AGAIN
    result INTEGER REFERENCES Player ON ON DELETE CASCADE ON UPDATE CASCADE,
    --------------------------------
    details TEXT,
    date DATE CONSTRAINT null_Match_date NOT NULL,
    duration_white TIME CONSTRAINT null_Match_durationWhite NOT NULL CONSTRAINT zero_Match_durationWhite CHECK(duration_white >= 0),
    duration_black TIME CONSTRAINT null_Match_durationBlack NOT NULL CONSTRAINT zero_Match_durationBlack CHECK(duration_black >= 0),
    increment INTEGER CONSTRAINT null_Match_increment NOT NULL CONSTRAINT zero_Match_increment CHECK(increment >= 0),
    number_of_moves INTEGER CONSTRAINT null_Match_numberOfMoves NOT NULL CONSTRAINT zero_Match_numberOfMoves CHECK(number_of_moves >= 0),
    id_tournament INTEGER REFERENCES Tournament ON ON DELETE CASCADE ON UPDATE CASCADE,
    id_website INTEGER REFERENCES WebsiteON ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: Sponsor
DROP TABLE IF EXISTS Sponsor;

CREATE TABLE Sponsor (
    id_sponsor INTEGER PRIMARY KEY,
    name TEXT CONSTRAINT null_Sponsor_name NOT NULL,
    phone_number INTEGER CONSTRAINT null_Sponsor_phone_number NOT NULL CONSTRAINT unique_Sponsor_phone_number UNIQUE,
    email TEXT CONSTRAINT null_Sponsor_email NOT NULL CONSTRAINT unique_Sponsor_email UNIQUE,
    adress TEXT CONSTRAINT unique_Sponsor_adress UNIQUE
);

-- Table: PlayerMatch
DROP TABLE IF EXISTS PlayerMatch;

CREATE TABLE PlayerMatch (
    id_player INTEGER REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    id_match INTEGER REFERENCES Match ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_player, id_match)
);

-- Table: PlayerTournament
DROP TABLE IF EXISTS PlayerTournament;

CREATE TABLE PlayerTournament (
    id_player INTEGER REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    id_tournament INTEGER REFERENCES Tournament ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_player, id_tournament)
);

-- Table: ChessClub
DROP TABLE IF EXISTS ChessClub;

CREATE TABLE ChessClub (
    id_club INTEGER PRIMARY KEY,
    name TEXT CONSTRAINT null_ChessClub_name NOT NULL CONSTRAINT unique_ChessClub_name UNIQUE,
    ranking INTEGER CONSTRAINT null_ChessClub_ranking NOT NULL CONSTRAINT zero_ChessClub_ranking CHECK (ranking >= 0),
    adress TEXT CONSTRAINT null_ChessClub_adress NOT NULL CONSTRAINT unique_ChessClub_adress UNIQUE,
    number_of_members INTEGER CONSTRAINT zero_ChessClub_number_of_members CHECK (number_of_members > 3)
);

-- Table: MemberId
DROP TABLE IF EXISTS MemberId;

CREATE TABLE MemberId (
    id_club INTEGER REFERENCES ChessClub ON DELETE CASCADE ON UPDATE CASCADE,
    id_player INTEGER REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    member_id INTEGER CONSTRAINT null_MemberId_member_id NOT NULL,
    PRIMARY KEY (id_club, id_player)
);

-- Table: PlayerSponsor
DROP TABLE IF EXISTS PlayerSponsor;

CREATE TABLE PlayerSponsor (
    id_player INTEGER REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    id_sponsor INTEGER REFERENCES Sponsor ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_player, id_sponsor)
);

-- Table: TournamentSponsor
DROP TABLE IF EXISTS TournamentSponsor;

CREATE TABLE TournamentSponsor (
    id_tournament INTEGER REFERENCES Tournament ON DELETE CASCADE ON UPDATE CASCADE,
    id_sponsor INTEGER REFERENCES Sponsor ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_tournament, id_sponsor)
);

-- Table: LevelOfSponsorPlayer
DROP TABLE IF EXISTS LevelOfSponsorPlayer;

CREATE TABLE LevelOfSponsorPlayer (
    id_player INTEGER REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    id_sponsor INTEGER REFERENCES Sponsor ON DELETE CASCADE ON UPDATE CASCADE,
    type TEXT CONSTRAINT null_LevelOfSponsorPlayer_type NOT NULL CONSTRAINT check_LevelOfSponsorPlayer_type CHECK (
        (
            type = "GOLD"
            OR type = "SILVER"
            OR type = "BRONZE"
        )
    ),
    PRIMARY KEY (id_player, id_sponsor)
);

-- Table: LevelOfSponsorTournament
DROP TABLE IF EXISTS LevelOfSponsorTournament;

CREATE TABLE LevelOfSponsorTournament (
    id_tournament INTEGER REFERENCES Tournament ON DELETE CASCADE ON UPDATE CASCADE,
    id_sponsor INTEGER REFERENCES Sponsor ON DELETE CASCADE ON UPDATE CASCADE,
    type TEXT CONSTRAINT null_LevelOfSponsorTournament_type NOT NULL CONSTRAINT check_LevelOfSponsorTournament_type CHECK (
        (
            type = "GOLD"
            OR type = "SILVER"
            OR type = "BRONZE"
        )
    ),
    PRIMARY KEY (id_tournament, id_sponsor)
);

-- Table: PlayerAccount
DROP TABLE IF EXISTS PlayerAccount;

CREATE TABLE PlayerAccount (
    id_player INTEGER REFERENCES Player ON DELETE CASCADE ON UPDATE CASCADE,
    id_account INTEGER REFERENCES Account ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_player, id_account)
);

-- Table: MatchChessClub
DROP TABLE IF EXISTS MatchChessClub;

CREATE TABLE MatchChessClub (
    id_match INTEGER REFERENCES Match ON DELETE CASCADE ON UPDATE CASCADE,
    id_club INTEGER REFERENCES ChessClub ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_match, id_club)
);

-- Table: TournamentChessClub
DROP TABLE IF EXISTS TournamentChessClub;

CREATE TABLE TournamentChessClub (
    id_tournament INTEGER REFERENCES TournamentON DELETE CASCADE ON UPDATE CASCADE,
    id_club INTEGER REFERENCES ChessClubON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(id_tournament, id_club)
);

COMMIT TRANSACTION;

PRAGMA foreign_keys = on;