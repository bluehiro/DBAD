USE [ohsu_refresh]
GO

/****** Object:  StoredProcedure [dbo].[RestoreDatabase]    Script Date: 2/24/2015 1:36:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* ============================================= 
Author: Vince James
Create date: 2015-02-24
Description: Called by Master_Refresh sproc - Not my code originally, removing dead code and cleaning up
SSIS Package:
Changelog:
    
EXEC RestoreDatabase
============================================= */


CREATE PROCEDURE [dbo].[RestoreDatabase]
@Database NVARCHAR(MAX),
@Directory NVARCHAR(MAX) = NULL
AS
BEGIN

	SET NOCOUNT ON;

	--Declare Variable(s)
	DECLARE @SQL VARCHAR(4000)
	DECLARE @CMD VARCHAR(1000)
	DECLARE @LogicalData VARCHAR(128)
	DECLARE @LogicalLog VARCHAR(128)
	DECLARE @TrimmedDatabase NVARCHAR(MAX)

	--Create Temp Table(s)
	CREATE TABLE #FILELISTONLY (
		LogicalName NVARCHAR(128),
		PhysicalName NVARCHAR(260),
		Type CHAR(1),
		FileGroupName NVARCHAR(128),
		Size NUMERIC(20, 0),
		MaxSize NUMERIC(20, 0),
		FileId TINYINT,
		CreateLSN NUMERIC(25, 0),
		DropLSN NUMERIC(25, 0),
		UniqueID UNIQUEIDENTIFIER,
		ReadOnlyLSN NUMERIC(25, 0),
		ReadWriteLSN NUMERIC(25, 0),
		BackupSizeInBytes BIGINT,
		SourceBlockSize INT,
		FileGroupId INT,
		LogGroupGUID UNIQUEIDENTIFIER,
		DifferentialBaseLSN NUMERIC(25, 0),
		DifferentialBaseGUID UNIQUEIDENTIFIER,
		IsReadOnly BIT,
		IsPresent BIT,
		TDEThumbprint VARBINARY(32)
	)

	SET @TrimmedDatabase = SUBSTRING(@Database, 2, LEN(@Database) - 2)

	SET @CMD = 'RESTORE FILELISTONLY FROM DISK=''' + @Directory + ''''
	INSERT INTO #FILELISTONLY
	EXEC (@CMD)

	SET @LogicalData = (SELECT
		LogicalName
	FROM #FILELISTONLY
	WHERE PhysicalName LIKE '%.mdf')
	SET @LogicalLog = (SELECT
		LogicalName
	FROM #FILELISTONLY
	WHERE PhysicalName LIKE '%.ldf')

	SET @CMD = 'ALTER DATABASE ' + @Database + ' SET OFFLINE WITH ROLLBACK IMMEDIATE'
	EXECUTE (@CMD)
	SET @CMD = 'ALTER DATABASE ' + @Database + ' SET ONLINE'
	EXECUTE (@CMD)
	SET @SQL = 'RESTORE DATABASE ' + @Database + ' FROM DISK = ''' + @Directory + ''' WITH REPLACE'
	EXECUTE (@SQL)

	SET @SQL = 'RESTORE DATABASE ' + @Database + ' FROM DISK = ''' + @Directory + ''' WITH MOVE ''' + @LogicalData + ''' TO ''F:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\' + @TrimmedDatabase + '.mdf'', MOVE ''' + @LogicalLog + ''' TO ''E:\MSSQL\' + @TrimmedDatabase + '.ldf'', REPLACE'

	--Clean up temp table(s)
	IF OBJECT_ID('tempdb..#FILELISTONLY') IS NOT NULL
	DROP TABLE #FILELISTONLY

END


GO