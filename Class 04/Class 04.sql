---Homework requirement1/2---
--Declare scalar variable for storing FirstName values--
---Assign value ‘Antonio’ to the FirstName variable
---Find all Students  having FirstName  same as the variable
DECLARE @FirstName nvarchar(50)
SET @FirstName = 'Antonio'

select *
from dbo.Student
where FirstName = @FirstName

--Declare table variable that will contain StudentId, StudentName and DateOfBirth--
---Fill the table variable with all Female  students
DECLARE @Student TABLE
(StudentId int, StudentName nvarchar(50), DateOfBirth date);
INSERT INTO @Student
select ID, FirstName, DateOfBirth
from dbo.Student
where Gender = 'F'

select *
from @Student

--Declare temp table that will contain LastName and EnrolledDate columns--
---Fill the temp table with all Male students having First Name starting with ‘A’
---Retrieve  the students  from the  table which last name  is with 7 characters
CREATE TABLE #Student_Enrollment
(LastName nvarchar(50), EnrolledDate date);
INSERT INTO #Student_Enrollment
select LastName, EnrolledDate
from dbo.Student
where FirstName like 'A%'

select * 
from #Student_Enrollment
where LEN(LastName) = 7

--Find all teachers whose FirstName length is less than 5 and--
---the first 3 characters of their FirstName  and LastNameare the same
select *
from dbo.Teacher
where LEN(FirstName) < 5 and LEFT(FirstName,3) = LEFT(LastName,3)

---Homework requirement2/2---
--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:--
---StudentCardNumberwithout “sc-”
---“ – “
---First character  of student  FirstName
---“.”
---Student LastName

CREATE FUNCTION dbo.fn_FormatStudentName (@StudentId int)
RETURNS Nvarchar(100)
AS 
BEGIN

DECLARE @FormatStudentName Nvarchar(100)

select @FormatStudentName = SUBSTRING(StudentCardNumber,4,8) + ' - ' + LEFT(FirstName,1) + '.' + dbo.Student.LastName
from dbo.Student
where id = @StudentId

RETURN @FormatStudentName

END

select dbo.fn_FormatStudentName (1) as 'Function_Output'

select *, dbo.fn_FormatStudentName(id) as 'Function_Output'
from dbo.Student