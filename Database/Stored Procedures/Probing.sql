﻿/****** Object:  Stored Procedure dbo.Probing    Script Date: 5/1/2004 6:12:40 PM ******/
CREATE PROCEDURE dbo.Probing
	(
		@Attacker int,
		@Defender int,
		@Probes bigint,
		@SKDate nvarchar(24),
		@Success nvarchar(512) output,
		@Result nvarchar(512) output
	)
AS
	DECLARE @AttackerSector int
	DECLARE @DefenderSector int
	DECLARE @AttackerAlliance int
	DECLARE @DefenderAlliance int
	DECLARE @DefenderNewbie int
	DECLARE @DefenderVacation int
	DECLARE @AttackerVacation int
	DECLARE @Sector1 int
	DECLARE @Sector2 int
	DECLARE @AttackerDead int
	SET @AttackerDead = (SELECT Dead FROM AccountStatus WHERE kdID = @Attacker)
	SET @DefenderVacation = (SELECT Vacation FROM AccountStatus WHERE kdID = @Defender)
	SET @AttackerVacation = (SELECT Vacation FROM AccountStatus WHERE kdID = @Attacker)
	SET @DefenderNewbie = (SELECT Newbie FROM AccountStatus WHERE kdID = @Defender)
	SET @Sector1 = @AttackerSector
	SET @Sector2 = @DefenderSector
	SET @AttackerSector = (SELECT SectorID FROM Kingdoms WHERE kdID = @Attacker)
	SET @DefenderSector = (SELECT SectorID FROM Kingdoms WHERE kdID = @Defender)
	SET @AttackerAlliance = (SELECT AllianceID FROM Sectors WHERE SectorID = @AttackerSector)
	SET @DefenderAlliance = (SELECT AllianceID FROM Sectors WHERE SectorID = @DefenderSector)
	IF @Probes > (SELECT Probes FROM Kingdoms WHERE kdID = @Attacker)
	BEGIN
	SET @Probes = (SELECT Probes FROM Kingdoms WHERE kdID = @Attacker)
	END
	IF @AttackerDead = 1
	BEGIN
		SET @Result = 'Your not able to probe when your dead.'
	END
	ELSE
	IF @DefenderNewbie = 1
	BEGIN
		SET @Result = 'The kingdom you are trying to probe is in newbie mode.'
	END
	ELSE
	IF @DefenderVacation = 1
	BEGIN
		SET @Result = 'The kingdom you are trying to probe is in vacation mode.'
	END
	ELSE
	IF @AttackerVacation = 1
	BEGIN
		SET @Result = 'You must leave vacation mode before probing.'
	END
	ELSE
	IF dbo.AllianceRelation(@Sector1, @Sector2) > 4
	BEGIN
		SET @Result = '0' /* nap */
	END
	ELSE
		BEGIN
				IF (SELECT Newbie FROM AccountStatus WHERE kdID = @Defender) = 1
				BEGIN
					SET @Result = '3' /* newbie */
				END
				ELSE
			BEGIN
				IF (SELECT Newbie FROM AccountStatus WHERE kdID = @Defender) = 1
				BEGIN
					SET @Result = '3' /* newbie */
				END
				ELSE
				BEGIN
					IF (SELECT Dead FROM AccountStatus WHERE kdID = @Defender) = 1
					BEGIN
						SET @Result = '4' /* dead */
					END
					ELSE
					BEGIN
						DECLARE @AttackPower bigint
						DECLARE @DefencePower bigint
						SET @AttackPower = dbo.CalcProbeAttackPower(@Attacker, @Defender, @Probes)
						SET @DefencePower = dbo.CalcProbingDefencePower(@Attacker, @Defender, @Probes)
						print @AttackPower
						print @DefencePower
						DECLARE @ProbesLostA bigint
						DECLARE @ProbesLostB bigint
						SET @ProbesLostA = @Probes * 0.02
						SET @ProbesLostB = @Probes * 0.04
						DECLARE @NewProbes bigint
						DECLARE @NewProbesB bigint
						SET @NewProbes = @Probes - @ProbesLostA
						SET @NewProbesB = @Probes - @ProbesLostB
						UPDATE Kingdoms SET ProbeTurns = ProbeTurns - 1 WHERE kdID = @Attacker
						DECLARE @AttackerName nvarchar(48)
						DECLARE @DefenderName nvarchar(48)
						SET @AttackerName = dbo.FullKingdomNameC(@Attacker)
						SET @DefenderName = dbo.FullKingdomNameC(@Defender)
						DECLARE @PersonalNews nvarchar(512)
						IF @AttackPower < @DefencePower
						BEGIN
							/* fail */
							SET @PersonalNews = 'We have recently been infiltrated by a failed probe attempt. Our intelligance reports that they came from  ' + @AttackerName + ' .<br>'
							SET @Result = 'I am sorry,  but our probes have failed to infiltrate the enemies defences. We have lost <b>' + dbo.FormatNumber(@ProbesLostB) + '</b> <b>probes</b>.<br>'
							SET @Success = 'Failed'
							UPDATE Kingdoms SET Probes = Probes - @ProbesLostB WHERE kdID = @Attacker
							INSERT INTO PersonalNews(kdID, NewsText) VALUES (@Defender, @PersonalNews)
						END
						ELSE
						BEGIN
							/* success */
							DECLARE @ResearchPercent int
							SET @ResearchPercent = (SELECT ResearchPercent FROM Research WHERE kdID = @Defender AND ResearchType = 4)
							UPDATE Kingdoms SET Probes = Probes - @ProbesLostA WHERE kdID = @Attacker
							SET @PersonalNews = 'We have recently been infiltrated by probes. We do not know who did it.  '
							IF @ResearchPercent >= 20 SET @PersonalNews =  'We have recently been infiltrated by probes.  Our intelligance reports that they came from  <b>' + @AttackerName + '</b>.'
							SET @Success = 'Success'
							SET @Result = 'Your probes have  <b>successfully</b> infiltrated the enemy kingdom. Many probes made it back, but  <b>' + dbo.FormatNumber(@ProbesLostA) + '</b> <b>probes</b> have been lost in this mission. Here is the report the probe computers gave us: '
							INSERT INTO PersonalNews(kdID, NewsText) VALUES (@Defender, @PersonalNews)
					END
				END
			END
		END
END
		IF @Success = NULL
		BEGIN
		SET @Success = 'Failed'
		END
