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

/****** Object:  Table [dbo].[DBA_PULL_freespace_history]    Script Date: 11/10/2014 11:19:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DBA_PULL_freespace_history]') AND type in (N'U')) PRINT 'Table DBA_PULL_freespace_history already exists'

IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[DBA_PULL_freespace_history]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[DBA_PULL_freespace_history](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[server_name] [nvarchar](128) NULL,
	[database_name] [varchar](100) NULL,
	[data_size_MB] [decimal](15, 2) NULL,
	[log_size_MB] [decimal](15, 2) NULL,
	[database_size_MB] [decimal](15, 2) NULL,
	[unallocated_space_MB] [decimal](15, 2) NULL,
	[retrievedate] [datetime] NULL
) ON [PRIMARY]
PRINT 'Table [DBA_PULL_freespace_history] created'
END
GO

SET ANSI_PADDING OFF
GO


