.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

-- It checks if a Player was inserted in the MemberId table and updates the table of the Club. If a Player is removed from the MemberId table it will also be removed from the Club table.
-- If a player is removed and the Club's member number becomes less than 3, the Club will also be deleted.

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
