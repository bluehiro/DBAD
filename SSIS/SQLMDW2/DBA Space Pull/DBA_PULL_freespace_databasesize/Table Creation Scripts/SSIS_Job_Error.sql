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

/****** Object:  Table [dbo].[SSIS_Job_Error_Log]    Script Date: 11/12/2014 10:49:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SSIS_Job_Error_Log]') AND type in (N'U')) PRINT 'Table SSIS_Job_Error_Log already exists'

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[SSIS_Job_Error_Log]') AND type in (N'U'))

CREATE TABLE [dbo].[SSIS_Job_Error_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[machinename] [nvarchar](128) NULL,
	[packagename] [nvarchar](128) NULL,
	[taskname] [nvarchar](128) NULL,
	[serverconnection] [nvarchar](128) NULL,
	[errormessage] [varchar](max) NOT NULL,
	[username] [nvarchar](128) NULL,
	[packagestartdate] [datetime] NULL,
	[retrievedate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
PRINT 'Table SSIS_Job_Error_Log created'
GO

SET ANSI_PADDING OFF
GO


