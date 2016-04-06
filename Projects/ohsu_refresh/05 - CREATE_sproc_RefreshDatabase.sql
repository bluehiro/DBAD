USE [ohsu_refresh]
GO

/****** Object:  StoredProcedure [dbo].[RefreshDatabase]    Script Date: 2/24/2015 1:36:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* ============================================= 
Author: Vince James
Create date: 2015-02-24
Description: Called by Master_Refresh sproc - Not my code originally, removing dead code and cleaning up
SSIS Package:
Changelog: Vince James - Redirected backup location to new \\msbdd1b\msb_sql\Adhoc share, simplified the logging
    
EXEC RefreshDatabase
============================================= */

CREATE PROCEDURE [dbo].[RefreshDatabase] 
	@SourceServer VARCHAR(50),
	@SourceDB VARCHAR(50),
	@DestServer VARCHAR(50),	
	@DestDB VARCHAR(50),
	@RefreshID INT,
	@Message VARCHAR(50),
	@Batch_UID INT
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @SQL VARCHAR(1000)
	DECLARE @DTStamp VARCHAR(32) = (SELECT REPLACE(REPLACE(REPLACE((convert(nvarchar(MAX), GETDATE(), 120)), '-', ''), ' ', '_'), ':', ''))
	DECLARE @BackupFile VARCHAR(512) = '''\\msbdd1b\msb_sql\Adhoc\TIER1DBD2_auto_refresh_' + @SourceDB +'_' + @DTStamp + '.bak'''

			--Log the batch details to the batch_log table
		INSERT INTO [dbo].[Refresh_Batch_Log] ([ID]
		, [Batch_Date]
		, [StoredProc]
		, [SourceServer]
		, [SourceDB]
		, [DestServer]
		, [DestDB])
			VALUES (@RefreshID, GETDATE(), 'RefreshDatabase', @SourceServer, @SourceDB, @DestServer, @DestDB)
	
	--Logging
	SET @Message = REPLACE(@Message, '- Master_Refresh', '- RefreshDatabase')
	INSERT INTO ohsu_refresh.dbo.Refresh_Log
		VALUES (@Batch_UID, @RefreshID, GETDATE(), NULL, '0201 Run BackupDatabase Sproc', @Message)

		--Backing up source database (this relies on a link server to work)	
		SET @SQL = 'EXECUTE ' + @SourceServer + '.ohsu_refresh.dbo.BackupDatabase ''' + @SourceDB + ''',' + @BackupFile
		EXECUTE (@SQL)

	--Logging
	INSERT INTO ohsu_refresh.dbo.Refresh_Log
		VALUES (@Batch_UID, @RefreshID, GETDATE(), NULL, '0202 Run ExportDBUsers sproc', @Message)

		--Exporting Dest Database Users	
		SET @SQL = 'EXECUTE ohsu_refresh.dbo.ExportDBUsers ''' + @DestDB + ''', ' + CAST(@RefreshID AS VARCHAR(50))
		EXECUTE (@SQL)

	--Logging
	INSERT INTO ohsu_refresh.dbo.Refresh_Log
		VALUES (@Batch_UID, @RefreshID, GETDATE(), NULL, '0203 Run RestoreDatabase sproc', @Message)

		--Restoring Dest Database
		SET @SQL = 'EXECUTE ohsu_refresh.dbo.RestoreDatabase ''' + @DestDB + ''',' + @BackupFile
		EXECUTE (@SQL)

	--Logging
	INSERT INTO ohsu_refresh.dbo.Refresh_Log
		VALUES (@Batch_UID, @RefreshID, GETDATE(), NULL, '0204 Run ReCreateUsers sproc', @Message)

		--Recreating Database Users
		SET @SQL = 'EXECUTE ohsu_refresh.dbo.ReCreateUsers ''' + @DestDB + ''',' + CAST(@RefreshID AS VARCHAR(50))
		EXECUTE (@SQL)

	--Logging
	INSERT INTO ohsu_refresh.dbo.Refresh_Log
		VALUES (@Batch_UID, @RefreshID, GETDATE(), NULL, '0205 Use xp_cmdshell to delete .bak file', @Message)

		PRINT @BackupFile --helps when troubleshooting

		--Deleting Backup File
		SET @SQL = REPLACE(('EXECUTE xp_cmdshell ''del ' + @BackupFile + ''), '''\', '\')
		EXECUTE (@SQL)

	--Logging
	INSERT INTO ohsu_refresh.dbo.Refresh_Log
		VALUES (@Batch_UID, @RefreshID, GETDATE(), NULL, '0206 RefreshDatabase Complete', @Message)
	
END




GO


