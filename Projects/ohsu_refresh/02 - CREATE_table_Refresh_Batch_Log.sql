USE [ohsu_refresh]
GO

/****** Object:  Table [dbo].[Refresh_Batch_Log]    Script Date: 2/24/2015 1:33:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Refresh_Batch_Log](
	[Batch_UID] [int] IDENTITY(1,1) NOT NULL,
	[Batch_Date] [datetime2](7) NOT NULL,
	[ID] [int] NOT NULL,
	[StoredProc] [varchar](50) NOT NULL,
	[SourceServer] [varchar](50) NULL,
	[SourceDB] [varchar](50) NULL,
	[DestServer] [varchar](50) NULL,
	[DestDB] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


