﻿/****** Object:  Stored Procedure dbo.CancelAlly    Script Date: 5/1/2004 6:12:37 PM ******/
CREATE PROCEDURE dbo.CancelAlly
	(
		@kdID int,
		@Result nvarchar(600) output
	)
AS
		DECLARE @AllianceAL int
		DECLARE @Alliance int
		DECLARE @AllianceName nvarchar(16)
		DECLARE @AllianceNameAL nvarchar(16)
		DECLARE @UniversalNews nvarchar(512)
		SET @AllianceAL = (SELECT AL FROM Alliances WHERE AL = @kdID)
		SET @AllianceName = (SELECT AllianceName FROM Alliances WHERE AllianceID = (SELECT Allie FROM Alliances WHERE AL = @kdID))
		SET @AllianceNameAL = (SELECT AllianceName FROM Alliances WHERE AL = @kdID)
		SET @UniversalNews = 'The <b>' + @AllianceNameAL + '</b> alliance has canceled their <b>ally</b> treaty with the <b>' + @AllianceName + '</b> alliance.'
		IF (SELECT Allie FROM Alliances WHERE AL = @kdID) = NULL
		BEGIN
			SET @Result = 'You did not have a ally set with anyone.'
		END
		ELSE
		BEGIN
		UPDATE Alliances SET Allie = NULL WHERE AllianceID = (SELECT Allie FROM Alliances WHERE AL = @kdID)
		UPDATE Alliances SET Allie = NULL WHERE AllianceID = (SELECT AllianceID FROM Alliances WHERE AL = @kdID)
		INSERT INTO UniversalNews(PublicID, NewsType, NewsText) VALUES(1, 7, @UniversalNews)
		SET @Result = 'You have canceled the ally treaty with the <b>' + @AllianceName + '</b> alliance. '
		END
