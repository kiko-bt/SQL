--Create multi-statement table value function that for specific Teacher and Course 
--will return list of students (FirstName, LastName) who passed the exam, together with Grade and CreatedDate

USE SEDCHome
GO

drop function if exists dbo.fn_PassedExams
GO


create function dbo.fn_PassedExams (@TeacherID int, @CourseID int)
returns @output table (StudentFirstName nvarchar(100), StudentLastName nvarchar(100), Grade int, CreatedDate date)
as
begin
	insert into @output
	select s.FirstName as StudentFirstName, s.LastName as StudentLastName, g.Grade as Grade, g.CreatedDate as CreatedDate
	from Grade as g
	inner join Student s
	on s.ID = g.StudentID
	where g.CourseID = @CourseID and g.TeacherID = @TeacherID
	group by s.FirstName, s.LastName, g.Grade, g.CreatedDate
	order by Grade
return
end
GO



declare @TeacherID int = 80
declare @CourseID int = 39

select * from  dbo.fn_PassedExams (@TeacherID, @CourseID)

