USE [ohsu_refresh]
GO

/****** Object:  Table [dbo].[Refresh_Log]    Script Date: 2/24/2015 1:34:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Refresh_Log](
	[Log_UID] [int] IDENTITY(1,1) NOT NULL,
	[Batch_UID] [int] NOT NULL,
	[RefreshID] [int] NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Step] [varchar](150) NULL,
	[Error] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


