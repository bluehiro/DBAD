USE [DBA_Rep]
GO

/****** Object:  Table [dbo].[DBA_PULL_freespace_history]    Script Date: 11/10/2014 11:19:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBA_PULL_freespace_history](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[server_name] [nvarchar](128) NULL,
	[database_name] [varchar](100) NULL,
	[data_size MB] [decimal](15, 2) NULL,
	[log_size MB] [decimal](15, 2) NULL,
	[database_size MB] [decimal](15, 2) NULL,
	[unallocated space MB] [decimal](15, 2) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


