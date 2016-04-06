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

/****** Object:  Table [dbo].[DBA_PULL_drivespace_history]    Script Date: 11/10/2014 11:27:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DBA_PULL_drivespace_history]') AND type in (N'U')) PRINT 'Table DBA_PULL_drivespace_history already exists'

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[DBA_PULL_drivespace_history]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[DBA_PULL_drivespace_history](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[servername] [varchar](50) NULL,
	[drive_letter] [char](1) NULL,
	[mb_free] [int] NULL,
	[retrievedate] [datetime] NULL
) ON [PRIMARY]
PRINT 'Table DBA_PULL_drivespace_history created'
END
GO

SET ANSI_PADDING OFF
GO


