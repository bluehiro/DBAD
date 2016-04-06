USE [ohsu_refresh]
GO

/****** Object:  Table [dbo].[Refresh]    Script Date: 2/24/2015 1:31:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Refresh](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SourceServer] [varchar](50) NOT NULL,
	[SourceDB] [varchar](50) NOT NULL,
	[DestServer] [varchar](50) NOT NULL,
	[DestDB] [varchar](50) NOT NULL,
	[ScheduledDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[CompletedDate] [datetime] NULL,
	[Project] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Refresh] ADD  CONSTRAINT [DF_Refresh_CompletedDate]  DEFAULT (getdate()) FOR [CompletedDate]
GO


