﻿/****** Object:  User Defined Function dbo.FullKingdomNameF    Script Date: 5/1/2004 6:12:42 PM ******/
CREATE FUNCTION dbo.FullKingdomNameF
	(
		@kdID int
	)
RETURNS nvarchar(100)
BEGIN
	DECLARE @Name nvarchar(100)
	SET @Name = (SELECT Kingdoms.[Name] + ' (' + CAST(Sectors.Galaxy AS nvarchar(2)) + ':' + CAST(Sectors.Sector AS nvarchar(2)) + ')' FROM Kingdoms, Sectors WHERE Kingdoms.kdID = @kdID AND Sectors.SectorID = Kingdoms.SectorID)
	SET @Name = '<a href=Profile.aspx?KingdomID=' + CAST(@kdID AS nvarchar(8)) + ' style="color: yellow;">' + @Name + '</a>'
	IF @Name = Null SET @Name = 'Nobody'
	RETURN(@Name)
END
