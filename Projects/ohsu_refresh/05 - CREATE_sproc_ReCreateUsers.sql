USE [ohsu_refresh]
GO

/****** Object:  StoredProcedure [dbo].[ReCreateUsers]    Script Date: 2/24/2015 1:35:55 PM ******/
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

    
EXEC ReCreateUsers
============================================= */

CREATE PROCEDURE [dbo].[ReCreateUsers] @Database NVARCHAR(MAX),
@RefreshID INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CMD VARCHAR(1000)
	DECLARE @Drop VARCHAR(1000)
	DECLARE @Create VARCHAR(1000)

	CREATE TABLE #Users (Line VARCHAR(4000))

	--Populate #Users with dynamic SQL
	SET @CMD = '''SELECT  ''''DROP USER '''' + QUOTENAME(dpl.name)
	FROM sys.database_permissions AS dp 
	INNER JOIN sys.database_principals AS dpl ON (dp.grantee_principal_id = dpl.principal_id) 
	WHERE dp.major_id = 0 
	and dpl.name not like ''''##%'''' -- excluds PBM accounts 
	and dpl.name not in (''''dbo'''', ''''sa'''', ''''public'''') 
	ORDER BY dp.permission_name ASC, dp.state_desc ASC'''
	INSERT INTO #Users
	EXEC ('USE ' + @Database + ' EXEC(' + @CMD + ')')

	--Users Cursor
	DECLARE c_Users CURSOR FOR
	SELECT
		'''' + Line + ''''
	FROM #Users

	OPEN c_Users

	FETCH NEXT FROM c_Users
	INTO @Drop

	WHILE @@fetch_status = 0
	BEGIN

		PRINT @Drop
		EXEC ('USE ' + @Database + ' EXEC(' + @Drop + ')')
		FETCH NEXT FROM c_Users
		INTO @Drop

	END
	CLOSE c_Users
	DEALLOCATE c_Users

	IF OBJECT_ID('tempdb..#Users') IS NOT NULL
		DROP TABLE #Users

	--Scripts Cursor
	DECLARE c_Scripts CURSOR FOR
	SELECT
		'''' + CMD + ''''
	FROM Refresh_Scripts
	WHERE RefreshID = @RefreshID
	ORDER BY ID

	OPEN c_Scripts

	FETCH NEXT FROM c_Scripts
	INTO @Create

	WHILE @@fetch_status = 0
	BEGIN

		PRINT @Create
	BEGIN TRY
		EXEC ('USE ' + @Database + ' EXEC(' + @Create + ')')
		FETCH NEXT FROM c_Scripts
		INTO @Create
	END TRY
	BEGIN CATCH
		FETCH NEXT FROM c_Scripts
		INTO @Create
	END CATCH

	END
	CLOSE c_Scripts
	DEALLOCATE c_Scripts

	--Clean up
	DELETE FROM Refresh_Scripts
	WHERE RefreshID = @RefreshID

END

GO


