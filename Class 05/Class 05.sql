---Homework requirement---
--Create multi-statement table value function that for specific Teacher 
--and Course will return list of students (FirstName, LastName) who passed the exam, 
--together with Grade and CreatedDate--

ALTER FUNCTION dbo.fn_exam_passed (@TeacherId int, @CourseId int)
RETURNS @Result TABLE 
(
FirstName nvarchar (50),
LastName nvarchar (50), 
Grade tinyint, 
CreatedDate nvarchar(50),
CourseName nvarchar(50),
TeacherFullName nvarchar(50)
)
AS

BEGIN
	INSERT INTO @Result
	select s.FirstName, s.LastName, g.Grade, left(convert(nvarchar(10),g.CreatedDate, 102),10), UPPER(c.Name), CONCAT(t.FirstName,' ',t.LastName)
	from dbo.Student as S
	inner join dbo.Grade as G on G.StudentID = S.ID
	inner join dbo.Teacher as T on T.ID = G.TeacherID
	inner join dbo.Course as C on C.ID = G.CourseID
	where G.TeacherID = @TeacherId and G.CourseID = @CourseId

RETURN
END

declare @TeacherId int = 1
declare @CourseId int = 1
select * from dbo.fn_exam_passed (@TeacherId, @CourseId)
order by Grade desc