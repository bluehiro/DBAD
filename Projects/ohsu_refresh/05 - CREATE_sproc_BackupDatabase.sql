USE [ohsu_refresh]
GO

/****** Object:  StoredProcedure [dbo].[BackupDatabase]    Script Date: 2/24/2015 1:34:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* ============================================= 
Author: Vince James
Create date: 2015-02-24
Description: Called by Master_Refresh sproc on TIER1DBD2 via linked server - Not my code originally, removing dead code and cleaning up
SSIS Package:
Changelog: 

    
EXEC [BackupDatabase]
============================================= */

CREATE PROCEDURE [dbo].[BackupDatabase] 
	-- Add the parameters for the stored procedure here
	@Database nvarchar(max),
	@Directory nvarchar(max) = NULL
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @SQL VARCHAR(1000)

	BACKUP DATABASE @Database TO DISK = @Directory
    
    --SET @SQL = 'BACKUP DATABASE ''' + @Database + ''' TO DISK=''' + @Directory + ''''
    
    --EXECUTE(@SQL)

END




GO


