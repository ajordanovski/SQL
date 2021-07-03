---Homework 7---
---Homework requirement 1/1---
--Add error handling on CreateGradeDetail procedure--
--Test the error handling by inserting not-existing values for AchievementTypeID--

CREATE OR ALTER PROCEDURE [dbo].[CreateGradeDetail] 
(
@GradeId int,
@AchievementTypeID tinyint, 
@AchievementPoints tinyint, 
@AchievementMaxPoints tinyint, 
@AchievementDate datetime
)

AS
BEGIN
BEGIN TRY
	INSERT INTO dbo.GradeDetails (GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
	VALUES (@GradeId, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)
END TRY
BEGIN CATCH  
SELECT  
    ERROR_NUMBER() AS ErrorNumber, 
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,  
    ERROR_PROCEDURE() AS ErrorProcedure,  
    ERROR_LINE() AS ErrorLine,  
    ERROR_MESSAGE() AS ErrorMessage  
END CATCH

SELECT sum(GD.AchievementPoints/GD.AchievementMaxPoints*ATYPE.ParticipationRate) as GradePoints
FROM dbo.GradeDetails GD
INNER JOIN dbo.AchievementType ATYPE on ATYPE.id = GD.AchievementTypeID
WHERE GD.AchievementTypeID = @AchievementTypeID

END

exec dbo.CreateGradeDetail @GradeID = 4, @AchievementTypeID = 11111111, @AchievementPoints = 50, @AchievementMaxPoints = 100, @AchievementDate = '2021.06.30'