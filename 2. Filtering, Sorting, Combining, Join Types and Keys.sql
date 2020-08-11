--Find all Students with FirstName = Antonio
select *
from Student
where FirstName like 'Antonio'

--Find all Students with DateOfBirth greater than ‘01.01.1999’
select *
from Student
where DateOfBirth > '01.01.1999'

--Find all Male students
select *
from Student
where Gender like 'M'

--Find all Students with LastName starting With ‘T’
select *
from Student
where LastName like 'T%'

--Find all Students Enrolled in January/1998
select *
from Student
where EnrolledDate between '1998-01-01' and '1998-01-31'

--Find all Students with LastName starting With ‘J’ enrolled in January/1998
select *
from Student
where EnrolledDate >= '1998-01-01' and EnrolledDate < '1998-01-31'
and LastName like 'J%'

--Find all Students with FirstName = Antonio ordered by Last Name
select *
from Student
where FirstName like 'Antonio'
order by LastName

--List all Students ordered by FirstName
select *
from Student
order by FirstName

--Find all Male students ordered by EnrolledDate, starting from the last enrolled
select *
from Student
order by EnrolledDate desc

--List all Teacher First Names and Student First Names in single result set with duplicates
select FirstName
from Teacher
union all
select FirstName
from dbo.Student

--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates
select LastName
from Teacher
union 
select LastName
from dbo.Student

--List all common First Names for Teachers and Students
select FirstName
from Teacher
intersect
select FirstName 
from Student

--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert
alter table GradeDetails
add constraint GD_GradeDetails
default 100 for [AchievementMaxPoints]

--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints
alter table [dbo].[GradeDetails] with check
add constraint chk_GradeDetails_AchievementPoints
check (AchievementPoints < AchievementMaxPoints)

--Change AchievementType table to guarantee unique names across the Achievement types
alter table [dbo].[AchievementType] with check
add constraint UC_AchievementType_Name UNIQUE (Name)    --doesn't have duplicates

--Create Foreign key constraints from diagram or with script
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Course] FOREIGN KEY([CourseID]) REFERENCES [dbo].[Course] ([ID])
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Student] FOREIGN KEY([StudentID]) REFERENCES [dbo].[Student] ([ID])
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Teacher] FOREIGN KEY([TeacherID]) REFERENCES [dbo].[Teacher] ([ID])
ALTER TABLE [dbo].[GradeDetails]  WITH CHECK ADD  CONSTRAINT [FK_GradeDetails_Grade] FOREIGN KEY([GradeID]) REFERENCES [dbo].[Grade] ([ID])
ALTER TABLE [dbo].[GradeDetails]  WITH CHECK ADD  CONSTRAINT [FK_GradeDetails_AchievementType] FOREIGN KEY([AchievementTypeID]) REFERENCES [dbo].[AchievementType] ([ID])


--List all possible combinations of Courses names and AchievementType names that can be passed by student
select c.Name as CoursesName, a.Name as AchievementTypeName
from dbo.Course c
cross join dbo.AchievementType a
GO

--List all Teachers that has any exam Grade
select distinct t.FirstName
from Grade g
inner join Teacher t
on t.ID = g.TeacherID
GO

--List all Teachers without exam Grade
select distinct t.FirstName
from Teacher t
left join Grade g 
on t.ID = g.TeacherID
where g.TeacherID is null

--List all Students without exam Grade (using Right Join)
select s.FirstName
from Grade g
right join Student s
on g.StudentID = s.ID
where g.StudentID is null











