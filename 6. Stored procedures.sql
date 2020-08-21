--Create new procedure called CreateGrade
--Procedure should create only Grade header info (not Grade Details) 
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)
--Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)

drop procedure if exists dbo.CreateGrade
GO

CREATE PROCEDURE dbo.[CreateGrade] (@Grade tinyint, @CreatedDate date, @StudentID int, @CourseID smallint, @TeacherID smallint) 
AS
BEGIN
	insert into dbo.Grade (Grade, CreatedDate, StudentID, CourseID, TeacherID)
	values (@Grade, @CreatedDate, @StudentID, @CourseID, @TeacherID)

	select count(*) as 'Total Number of Grades'
	from dbo.[Grade] 
	where StudentID = @StudentID

	select MAX(Grade) as 'Max Grade'
	from dbo.[Grade] 
	where StudentID = @StudentID
	and TeacherID = @TeacherID
END
GO

exec dbo.CreateGrade 
@Grade = 9, 
@CreatedDate = '2000-03-10', 
@StudentID = 404, 
@CourseID = 4, 
@TeacherID = 38 


--Create new procedure called CreateGradeDetail
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
--Output from this procedure should be resultset with SUM of GradePoints calculated with formula AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade

drop procedure if exists dbo.CreateGradeDetail
GO

CREATE PROCEDURE dbo.CreateGradeDetail (@GradeID int ,@AchievementTypeID tinyint, @AchievementPoints tinyint, @AchievementMaxPoints tinyint, @AchievementDate date)
AS
BEGIN
	insert into dbo.GradeDetails ([GradeID], [AchievementTypeID], [AchievementPoints], [AchievementMaxPoints], [AchievementDate])
    values (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)
    
    select  SUM((cast(gd.AchievementPoints as decimal)/cast(gd.AchievementMaxPoints as decimal)) * a.ParticipationRate) as 'Result of Grade Points'
    
    from dbo.[GradeDetails] gd
    inner join dbo.AchievementType a on a.ID = gd.AchievementTypeID
    
    where 
    gd.GradeID = @GradeID
END
GO

exec dbo.CreateGradeDetail
@GradeID = 3,  
@AchievementTypeID = 2,
@AchievementPoints = 4,
@AchievementMaxPoints = 98 ,
@AchievementDate = '2011-03-05'


