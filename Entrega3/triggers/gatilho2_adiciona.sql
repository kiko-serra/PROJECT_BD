.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

--
Create Trigger IF NOT EXISTS UpdateMembers
After Insert on MemberId
For Each Row
When exists (select Player.id_player from Player where Player.id_player = New.id_player)
Begin
    UPDATE ChessClub SET number_of_members = number_of_members + 1
    WHERE (SELECT MemberId.id_club FROM MemberId) = ChessClub.id_club;
End;