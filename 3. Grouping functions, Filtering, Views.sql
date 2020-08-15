--Calculate the count of all grades in the system
select COUNT(*) as 'Count'
from Grade
GO

--Calculate the count of all grades per Teacher in the system
select TeacherID, COUNT(*) as 'Count'
from dbo.Grade 
group by TeacherID
GO

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
select TeacherID, Count(*) as 'Count'
from dbo.Grade 
where StudentID < 100 
group by TeacherID
GO

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select StudentID, MAX(Grade) as Total, AVG(Grade) as Average
from dbo.Grade
group by StudentID
GO

--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
select TeacherID, COUNT(*) as 'Count'
from dbo.Grade
group by TeacherID
having COUNT(Grade) > 200
GO

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count
select TeacherID, COUNT(*) as 'Count'
from dbo.Grade
where StudentID < 100 
group by TeacherID
having COUNT(Grade) > 50
GO

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
select StudentID ,COUNT(*) as 'Count', MAX(Grade) as 'Total', AVG(Grade) as 'Average'
from dbo.Grade
group by StudentID
having MAX(Grade) = AVG(Grade)
GO

--List Student First Name and Last Name next to the other details from previous query
select StudentID, s.FirstName, s.LastName, COUNT(*) as 'Count', MAX(Grade) as 'Total', AVG(Grade) as 'Average'
from dbo.Grade g
inner join Student s
on s.ID = g.StudentID
group by StudentID, s.FirstName, s.LastName
having MAX(Grade) = AVG(Grade)
GO

--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
drop view if exists vv_StudentGrades
GO
create view vv_StudentGrades
as
select StudentID, Count(*) as TotalPrice
from dbo.[Grade] g
group by StudentID
GO

--Change the view to show Student First and Last Names instead of StudentID
alter view vv_StudentGrades
as
select COUNT(StudentID) as 'Count', s.FirstName, s.LastName
from dbo.[Grade] g
inner join Student s
on s.ID = g.StudentID
group by StudentID, s.FirstName, s.LastName
GO

--List all rows from view ordered by biggest Grade Count
select Count
from vv_StudentGrades
group by Count
order by Count desc
GO


--Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)
drop view if exists vv_StudentGradeDetails
GO
create view vv_StudentGradeDetails
as 
select s.FirstName + ' ' + s.LastName as 'Student Name', COUNT(g.CourseID) as 'Course Count'
from Grade as g
inner join Student s
on s.ID = g.StudentID
inner join GradeDetails gd
on gd.GradeID = g.ID
inner join AchievementType a
on a.ID = gd.AchievementTypeID
where a.Name = 'Ispit'
group by s.FirstName, s.LastName
GO


---------------------------------

select * 
from vv_StudentGradeDetails
order by [Course Count] desc, [Student Name] asc
















