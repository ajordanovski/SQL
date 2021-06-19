---Homework requirement1/3---
--Calculate the count of all grades in the system--
SELECT COUNT(Grade) as Grade_Count
FROM dbo.Grade

--Calculate the count of all grades per Teacher in the system--
SELECT TeacherID, COUNT(Grade) as Grade_Count
FROM dbo.Grade
GROUP BY TeacherID
ORDER BY TeacherID

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)--
SELECT TeacherID, COUNT(Grade) as Grade_Count
FROM dbo.Grade
WHERE StudentID < 100
GROUP BY TeacherID
ORDER BY TeacherID

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system--

SELECT StudentID, MAX(Grade) as Max_Grade, AVG(Grade) as Avg_Grade
FROM dbo.Grade
GROUP BY StudentID
ORDER BY StudentID

---Homework requirement2/3---
--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200--
SELECT TeacherID, COUNT(Grade) as Grade_Count
FROM dbo.Grade
GROUP BY TeacherID
HAVING COUNT(Grade) > 200
ORDER BY TeacherID

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count--
SELECT TeacherID, COUNT(Grade) as Grade_Count
FROM dbo.Grade
WHERE StudentID < 100
GROUP BY TeacherID
HAVING COUNT(Grade) > 50
ORDER BY TeacherID

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. 
--Filter only records where Maximal Grade is equal to Average Grade--
SELECT StudentID, MAX(Grade) as Max_Grade, AVG(Grade) as Avg_Grade
FROM dbo.Grade
GROUP BY StudentID
HAVING MAX(Grade) = AVG(Grade)
ORDER BY StudentID

--List Student First Name and Last Name next to the other details from previous query--
SELECT StudentID, MAX(Grade) as Max_Grade, AVG(Grade) as Avg_Grade, S.FirstName as Name, S.LastName as LastName
FROM dbo.Grade as G
INNER JOIN dbo.Student as S ON S.ID = G.StudentID
GROUP BY StudentID, S.FirstName, S.LastName
HAVING MAX(Grade) = AVG(Grade)
ORDER BY StudentID

---Homework requirement3/3---
--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student--
CREATE VIEW vv_StudentGrades
AS
select StudentID, COUNT(Grade) as Grade_Count
from dbo.Grade as G
group by StudentID

select *
from vv_StudentGrades
--Change the view to show Student First and Last Names instead of StudentID--
ALTER VIEW vv_StudentGrades
AS
select S.FirstName, S.LastName, COUNT(Grade) as Grade_Count
from dbo.Grade G
inner join dbo.Student S on S.ID = G.StudentID
group by S.FirstName, S.LastName

select *
from vv_StudentGrades
--List all rows from view ordered by biggest Grade Count--
select *
from vv_StudentGrades
order by Grade_Count desc

--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)--
CREATE VIEW vv_StudentGradeDetails
AS
select S.FirstName, S.LastName, COUNT(Name) as Exam_Count
from dbo.Grade G
inner join dbo.Student S on S.ID = G.StudentID
inner join dbo.Course C on C.ID = G.CourseID
group by S.FirstName, S.LastName

select *
from vv_StudentGradeDetails