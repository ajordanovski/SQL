---Homework 6---
---Homework requirement 1a/2---
--Create new procedure called CreateGrade--
--Procedure should create only Grade header info (not Grade Details)--
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)--
--Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)--

CREATE OR ALTER PROCEDURE dbo.CreateGrade (@Grade tinyint, @CreatedDate date, @StudentId int, @TeacherId int, @CourseId int)
AS
BEGIN
	
	INSERT INTO dbo.Grade (Grade, CreatedDate, StudentID, TeacherID, CourseID)
	VALUES (@Grade, @CreatedDate, @StudentId, @TeacherId, @CourseId)

	
	select count(*) as TotalGrades
	FROM dbo.[Grade] g
	where StudentID = @StudentId

	select max(g.Grade) as MaxGrade
	FROM dbo.[Grade] g
	where StudentID = @StudentId
	and TeacherID = @TeacherId

END

EXEC dbo.CreateGrade @Grade = 9, @CreatedDate = '2021.06.30', @StudentId = 1, @TeacherId = 1, @CourseId = 1 

select top 10 * 
from dbo.Grade
order by 1 desc

---Homework requirement 1b/2---
--Create new procedure called CreateGradeDetail--
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)--
--Output from this procedure should be result set with SUM of GradePoints calculated with formula:
--AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade--

CREATE OR ALTER PROCEDURE dbo.CreateGradeDetail 
(
@GradeId int,
@AchievementTypeID tinyint, 
@AchievementPoints tinyint, 
@AchievementMaxPoints tinyint, 
@AchievementDate datetime
)

AS
BEGIN

INSERT INTO dbo.GradeDetails (GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
VALUES (@GradeId, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)

SELECT sum(GD.AchievementPoints/GD.AchievementMaxPoints*ATYPE.ParticipationRate) as GradePoints
FROM dbo.GradeDetails GD
INNER JOIN dbo.AchievementType ATYPE on ATYPE.id = GD.AchievementTypeID
WHERE GD.AchievementTypeID = @AchievementTypeID

END

exec dbo.CreateGradeDetail @GradeID = 4, @AchievementTypeID = 4, @AchievementPoints = 50, @AchievementMaxPoints = 100, @AchievementDate = '2021.06.30'
