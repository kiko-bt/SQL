create database [Faculty]
go

use [Faculty]
go

drop table if exists [dbo].[Student]
drop table if exists [dbo].[Teacher]
drop table if exists [dbo].[GradeDetails]
drop table if exists [dbo].[Course]
drop table if exists [dbo].[Grade]
drop table if exists [dbo].[AchievementType]
go

CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](569) NOT NULL,
	[LastName] [nvarchar](569) NOT NULL,
	[DateOfBirth] [date] NULL,
	[AcademicRank] [nvarchar](50) NOT NULL,
	[HireDate] [date] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Teacher](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](88) NOT NULL,
	[LastName] [nvarchar](88) NOT NULL,
	[DateOfBirth] [date] NULL,
	[AcademicRank] [nvarchar](50) NOT NULL,
	[HireDate] [date] NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[GradeDetails]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GradeID] [int] NOT NULL,
	[AchievementTypeID] [int] NOT NULL,
	[AchievementPoints] [int] NOT NULL,
	[AchievementMaxPoints] [int] NOT NULL,
	[AchievementDate] [datetime] NOT NULL,
CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Course]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Credit] [int] NOT NULL,
	[AcademicYear] [tinyint] NOT NULL,
	[Semestar] [tinyint] NOT NULL,
CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
)
GO

CREATE TABLE [dbo].[Grade](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [bigint] NOT NULL,
	[CourseID] [int] NOT NULL,
	[TeacherID] [bigint] NOT NULL,
	[Grade] [int] NULL,
	[Comment] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
) 
GO

CREATE TABLE [dbo].[AchievementType]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[ParticipationRate] [int] NOT NULL,
	CONSTRAINT [PK_AchievementType] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO


exec sp_help Student;
exec sp_help Teacher;
exec sp_help GradeDetails;
exec sp_help Course;
exec sp_help Grade;
exec sp_help AchievementType;

