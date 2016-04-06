USE [ohsu_refresh]
GO

/****** Object:  Table [dbo].[Refresh_Scripts]    Script Date: 2/24/2015 1:34:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Refresh_Scripts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RefreshID] [int] NOT NULL,
	[CMD] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


