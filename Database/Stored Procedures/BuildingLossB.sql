﻿/****** Object:  Stored Procedure dbo.BuildingLossB    Script Date: 5/1/2004 6:12:39 PM ******/
CREATE PROCEDURE dbo.BuildingLossB
(
		@Attacker int,
		@Defender int 
)
AS
							DECLARE @LandGain int
							SET @LandGain = dbo.NuclearLoss(@Attacker, @Defender)
							IF (SELECT Built FROM Buildings WHERE BuildingType = 0 AND kdID = @Defender) < @LandGain * .25
							UPDATE Buildings SET Built = 0 WHERE BuildingType = 0 AND kdID = @Defender
							ELSE
							UPDATE Buildings SET Built = Built - (@LandGain * .25) WHERE BuildingType = 0 AND kdID = @Defender
							IF (SELECT Built FROM Buildings WHERE BuildingType = 1 AND kdID = @Defender) < @LandGain * .25
							UPDATE Buildings SET Built = 0 WHERE BuildingType = 1 AND kdID = @Defender
							ELSE
							UPDATE Buildings SET Built = Built - (@LandGain * .25) WHERE BuildingType = 1 AND kdID = @Defender
							IF (SELECT Built FROM Buildings WHERE BuildingType = 5 AND kdID = @Defender) < @LandGain * .25
							UPDATE Buildings SET Built = 0 WHERE BuildingType = 5 AND kdID = @Defender
							ELSE
							UPDATE Buildings SET Built = Built - (@LandGain * .25) WHERE BuildingType = 5 AND kdID = @Defender
							IF (SELECT Built FROM Buildings WHERE BuildingType = 3 AND kdID = @Defender) < @LandGain * .25
							UPDATE Buildings SET Built = 0 WHERE BuildingType = 3 AND kdID = @Defender
							ELSE
							UPDATE Buildings SET Built = Built - (@LandGain * .25) WHERE BuildingType = 3 AND kdID = @Defender
