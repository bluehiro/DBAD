USE [ohsu_refresh]
GO

/****** Object:  StoredProcedure [dbo].[ExportDBUsers]    Script Date: 2/24/2015 1:35:14 PM ******/
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

    
EXEC ExportDBUsers
============================================= */

CREATE PROCEDURE [dbo].[ExportDBUsers] 
	@Database nvarchar(max),
	@RefreshID INT
AS
BEGIN

	SET NOCOUNT ON;
	
	--Declare Variable(s)
	DECLARE @CMD VARCHAR(1000)
	
	--Create temp table
	CREATE TABLE #Out (Line VARCHAR(4000))
	
	SET @CMD = '''SELECT ''''CREATE USER '''' + QUOTENAME(dpl.name) + '''' FOR LOGIN '''' + QUOTENAME(dpl.name) 
	FROM sys.database_permissions AS dp 
	INNER JOIN sys.database_principals AS dpl ON (dp.grantee_principal_id = dpl.principal_id) 
	WHERE dp.major_id = 0 
	and dpl.name not like ''''##%''''
	and dpl.name not in (''''dbo'''', ''''sa'''', ''''public'''') 
	ORDER BY dp.permission_name ASC, dp.state_desc ASC'''
	INSERT INTO #Out
	EXEC('USE ' + @Database + ' EXEC(' + @CMD + ')')
	
	SET @CMD = '''SELECT dp.state_desc + '''' '''' + dp.permission_name + '''' TO '''' + cast(QUOTENAME(dpl.name COLLATE DATABASE_DEFAULT) as nvarchar(500))  AS "T-SQL Script" 
	FROM sys.database_permissions AS dp 
	INNER JOIN sys.database_principals AS dpl ON (dp.grantee_principal_id = dpl.principal_id) 
	WHERE dp.major_id = 0 
	and dpl.name not like ''''##%''''
	and dpl.name not in (''''dbo'''', ''''sa'''', ''''public'''') 
	ORDER BY dp.permission_name ASC, dp.state_desc ASC'''
	INSERT INTO #Out
	EXEC('USE ' + @Database + ' EXEC(' + @CMD + ')')
	
	SET @CMD = '''SELECT DISTINCT ''''EXEC sp_addrolemember @membername = '''' + cast(QUOTENAME(dp.name COLLATE DATABASE_DEFAULT) as nvarchar(500)) + '''', @rolename = '''' + drole.name + '''''''' AS "T-SQL Script" 
	FROM sys.database_role_members AS drm 
	inner join sys.database_principals drole on (drm.role_principal_id = drole.principal_id) 
	inner join sys.database_principals dp on (drm.member_principal_id = dp.principal_id) 
	where dp.name not in (''''dbo'''', ''''sa'''', ''''public'''')'''
	INSERT INTO #Out
	EXEC('USE ' + @Database + ' EXEC(' + @CMD + ')')
	
	--Verify that DB Users have not already been exported
	IF (SELECT COUNT(*) FROM Refresh_Scripts WHERE RefreshID = @RefreshID) = 0
	BEGIN
	
		INSERT INTO Refresh_Scripts (RefreshID, CMD)
		SELECT @RefreshID,Line FROM #Out
		
	END

	--Clean up temp table(s)
	IF OBJECT_ID('tempdb..#Out') IS NOT NULL
		DROP TABLE #Out
	
	
END





GO


