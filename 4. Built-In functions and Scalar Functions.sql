USE SEDCHome
GO

--Declare scalar variable for storing FirstName values
--Assign value ‘Antonio’ to the FirstName variable
--Find all Students having FirstName same as the variable

DECLARE @FirstName nvarchar(100)
SET @FirstName = 'Antonio'
select *
from Student
where FirstName = @FirstName
GO

--Declare table variable that will contain StudentId, StudentName and DateOfBirth
--Fill the table variable with all Female students

DECLARE @MyTable TABLE (StudentID int, StudentName nvarchar(100), DateOfBirth date)
INSERT into @MyTable
select ID, FirstName, DateOfBirth
from Student
where Gender = 'F'

select * from @MyTable
GO

--Declare temp table that will contain LastName and EnrolledDate columns
--Fill the temp table with all Male students having First Name starting with ‘A’
--Retrieve the students from the table which last name is with 7 characters

CREATE TABLE #StudentList 
(LastName nvarchar(100), EnrolledDate date)
INSERT into #StudentList
select LastName, EnrolledDate
from Student
where FirstName like 'A%'

select *
from #StudentList
where LEN(LastName) = 7


--Find all teachers whose FirstName length is less than 5 and
--the first 3 characters of their FirstName and LastName are the same
select FirstName
from Teacher
where LEN(FirstName) < 5 AND SUBSTRING(FirstName, 1, 3) = SUBSTRING(LastName, 1, 3)
GO

--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:
--StudentCardNumber without “sc-”
--“ – “
--First character of student FirstName
--“.”
--Student LastName

drop function if exists dbo.fn_FormatStudentName

CREATE FUNCTION dbo.fn_FormatStudentName (@StudentID int)
RETURNS nvarchar(2000)
AS 
BEGIN
	DECLARE @Output nvarchar(2000)

	select @Output = SUBSTRING(StudentCardNumber, 4, 6) + ' - ' + RIGHT(FirstName, 1) + '.' + LastName
	from dbo.Student 
	where ID = @StudentID
	RETURN @Output
END
GO



select dbo.fn_FormatStudentName(5) as 'Function Output'
--select *, dbo.fn_FormatStudentName(ID) as 'Function Output' from Student   -->  you can retrieve all students from Student table by ID





