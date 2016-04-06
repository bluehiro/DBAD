/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
USE [DBA_Rep]
GO

/****** Object:  Table [dbo].[DBA_PULL_SQL_Jobs]    Script Date: 11/10/2014 11:26:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DBA_PULL_SQL_Jobs]') AND type in (N'U')) PRINT 'Table DBA_PULL_SQL_Jobs already exists'

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[DBA_PULL_SQL_Jobs]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[DBA_PULL_SQL_Jobs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[JobName] [sysname] NOT NULL,
	[JobOwner] [sysname] NULL,
	[JobCategory] [sysname] NULL,
	[JobDescription] [nvarchar](512) NULL,
	[IsEnabled] [varchar](3) NULL,
	[JobCreatedOn] [datetime] NOT NULL,
	[JobLastModifiedOn] [datetime] NOT NULL,
	[OriginatingServerName] [sysname] NULL,
	[IsScheduled] [varchar](3) NOT NULL,
	[JobScheduleID] [uniqueidentifier] NULL,
	[JobScheduleName] [sysname] NULL,
	[JobOperatorName] [sysname] NULL,
	[JobNotificationEmail] [nvarchar](100) NULL
) ON [PRIMARY]
PRINT 'Table DBA_PULL_SQL_Jobs created'
END

GO

SET ANSI_PADDING OFF
GO


