.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

-- Update the number of members in a Chess Club.

CREATE Trigger IF NOT EXISTS UpdateMembersInsert
AFTER INSERT ON MemberId
WHEN EXISTS (SELECT id_player FROM Player WHERE id_player = New.id_player)
BEGIN
    UPDATE ChessClub 
    SET number_of_members = number_of_members + 1
    WHERE NEW.id_club = id_club;
END;

CREATE Trigger IF NOT EXISTS UpdateMembersRemove
AFTER DELETE ON MemberId
WHEN EXISTS (SELECT id_player FROM Player WHERE id_player = OLD.id_player)
BEGIN
    UPDATE ChessClub 
    SET number_of_members = number_of_members - 1
    WHERE OLD.id_club = id_club;
    DELETE FROM ChessClub WHERE OLD.id_club = id_club AND number_of_members < 3;
END;