---Homework requirement 1/6---
--Find all Students with FirstName= Antonio--
SELECT *
FROM dbo.Student
WHERE FirstName = 'Antonio'

--Find all Students with DateOfBirth greater than ‘01.01.1999’--
SELECT *
FROM dbo.Student
WHERE DateOfBirth > '1999-01-01'

--Find all Male students--
SELECT *
FROM dbo.Student
WHERE Gender = 'M'

--Find all Students with LastNamestarting With ‘T’--
SELECT *
FROM dbo.Student
WHERE LastName like 'T%'

--Find all Students Enrolled in January/1998--
SELECT *
FROM dbo.Student
WHERE EnrolledDate >= '1998-01-01' and EnrolledDate <= '1998-01-31'

--Find all Students with LastName starting With ‘J’ enrolled in January/1999--(go promeniv od 1998 vo 1999 za da mi najde podatok)
SELECT *
FROM dbo.Student
WHERE LastName like 'J%' and EnrolledDate >= '1999-01-01' and EnrolledDate <= '1999-01-31'


---Homework requirement 2/6---
--Find all Students with FirstName= Antonio ordered by Last Name--
SELECT *
FROM dbo.Student
WHERE FirstName = 'Antonio'
ORDER BY LastName

--List all Students ordered by FirstName--
SELECT *
FROM dbo.Student
ORDER BY FirstName

--Find all Male students ordered by EnrolledDate, starting from the last enrolled--
SELECT *
FROM dbo.Student
WHERE Gender = 'M'
ORDER BY EnrolledDate desc


---Homework requirement 3/6---
--List all Teacher First Names and Student First Names in single result set with duplicates--
SELECT FirstName
FROM dbo.Teacher
UNION ALL
SELECT FirstName
FROM dbo.Student

--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates--
SELECT LastName
FROM dbo.Teacher
UNION
SELECT LastName
FROM dbo.Student

--List all common First Names for Teachers and Students--
SELECT FirstName
FROM dbo.Teacher
INTERSECT
SELECT FirstName
FROM dbo.Student


---Homework requirement 4/6---
--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert--
ALTER TABLE GradeDetails
ADD CONSTRAINT DF_GradeDetails_AchievementMaxPoints
DEFAULT 100 FOR [AchievementMaxPoints]

--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints-- ovde mi javuva greska!!!!!!!!!!!!
ALTER TABLE [dbo].[GradeDetails] WITH CHECK
ADD CONSTRAINT CHK_GradeDetails_AchievementPoints
CHECK (AchievementPoints <= AchievementMaxPoints)

--Change AchievementType table to guarantee unique names across the Achievement types--
ALTER TABLE [dbo].[AchievementType] WITH CHECK
ADD CONSTRAINT UC_AchievementType_Name UNIQUE (Name)

---Homework requirement 5/6---
--Create Foreign key constraints from diagram or with script--
ALTER TABLE dbo.[Grade] WITH CHECK
ADD CONSTRAINT [FK_Grade_Student]
FOREIGN KEY (StudentID) REFERENCES dbo.Student(ID)

ALTER TABLE dbo.[Grade] WITH CHECK
ADD CONSTRAINT [FK_Grade_Teacher]
FOREIGN KEY (TeacherID) REFERENCES dbo.Teacher(ID)

ALTER TABLE dbo.[Grade] WITH CHECK
ADD CONSTRAINT [FK_Grade_Course]
FOREIGN KEY (CourseID) REFERENCES dbo.Course(ID)

ALTER TABLE dbo.[GradeDetails] WITH CHECK
ADD CONSTRAINT [FK_GradeDetails_AchievementType]
FOREIGN KEY (AchievementTypeID) REFERENCES dbo.AchievementType(ID)

---Homework requirement 6/6---
--List all possible combinations of Courses names and AchievementType names that can be passed by student--


--List all Teachers that has any exam Grade--


--List all Teachers without exam Grade--


--List all Students without exam Grade (using Right Join)--