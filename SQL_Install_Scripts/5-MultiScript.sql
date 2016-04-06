/* ============================================= 
MultiScript - Standard OHSU SQL Server Install Scripts
Author: Various (Vince James, Olga Tsytsyn, Dan Otto, Dimitri Vizen)
Create Date: 2015-08-27
Description: This script is a combination of various scripts that: 
	do not often need to be run or re-run separately
	are dev/prod agnostic

Note: Increment the @Version value if you make any changes

ChangeLog:
2015-08-27 VMJ - Initital Creation

============================================= */

DECLARE @Version VARCHAR(16)
SET @Version = '0.1'

PRINT '*************************************************'
PRINT '------------- BEGIN MultiScript '+ @Version + ' -------------'
PRINT '*************************************************'


PRINT '******************************************************'
PRINT '01 Create standard logins and grant rights to DBAD groups'
PRINT '******************************************************'

use master
go
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 07/11/2007 12:36:43 ******/
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 07/11/2007 12:36:43 ******/

IF NOT  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]


EXEC master..sp_addsrvrolemember @loginame = N'NT AUTHORITY\SYSTEM', @rolename = N'sysadmin'
go
/****** Object:  Login [OHSUM01\SQL Server Admins]    Script Date: 07/11/2007 12:37:44 ******/
/****** Object:  Login [OHSUM01\SQL Server Admins]    Script Date: 07/11/2007 12:37:44 ******/
CREATE LOGIN [OHSUM01\SQL Server Admins] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
go
EXEC master..sp_addsrvrolemember @loginame = N'OHSUM01\SQL Server Admins', @rolename = N'sysadmin'
go
/****** Object:  Login [OHSUM01\ITG DBAD]    Script Date: 07/11/2007 12:37:44 ******/
/****** Object:  Login [OHSUM01\ITG DBAD]    Script Date: 07/11/2007 12:37:44 ******/
CREATE LOGIN [OHSUM01\ITG DBAD] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
go
EXEC master..sp_addsrvrolemember @loginame = N'OHSUM01\ITG DBAD', @rolename = N'sysadmin'
go

/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 07/11/2007 12:38:43 ******/
/****** Object:  Login [BUILTIN\Administrators]    Script Date: 07/11/2007 12:39:35 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'BUILTIN\Administrators')
DROP LOGIN [BUILTIN\Administrators]
go
PRINT '******************************************************'
PRINT '01 END'
PRINT '******************************************************'
PRINT ''
PRINT '****************************************'
PRINT '02 Set model db to 50MB with growth of 50mb'
PRINT '****************************************'
/*
	At installation, the model database (which serves as a template for any new databases) has very small file size and auto-growth parameters.
	Growing databases in many small increments leads to fragmentation disk and longer IO times.

	This script sets larger values for the model DB preventing the worst fragmentation issues, but you should size
 	any new database large enough for at least a year's growth, and the autogrow amount should also be large

	-- Handy procs to look at the database files and disk free space
	exec sp_helpdb
	use model; EXEC sp_helpfile
	xp_fixeddrives

*/

USE [master]
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', SIZE = 50MB , FILEGROWTH = 50MB )
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modellog', SIZE = 20MB , FILEGROWTH = 50MB )
GO

PRINT '****************************************'
PRINT '02 END'
PRINT '****************************************'
PRINT ''
PRINT '******************************************************************************'
PRINT '03 Servers with Dev/User/Test in their name model DB recovery is set to Simple'
PRINT '******************************************************************************'

DECLARE @ServerName VARCHAR(300)
DECLARE @Dev TINYINT

SET @ServerName = (SELECT @@servername)
SET @Dev = 0

IF @ServerName LIKE '%dev%'  SET @Dev = 1
IF @ServerName LIKE '%tst%'  SET @Dev = 1
IF @ServerName LIKE '%test%' SET @Dev = 1
IF @ServerName LIKE '%usr%'  SET @Dev = 1
IF @ServerName LIKE '%user%' SET @Dev = 1

IF @Dev = 1 ALTER DATABASE model SET RECOVERY SIMPLE 
IF @Dev = 0 ALTER DATABASE model SET RECOVERY FULL
IF @Dev = 1 PRINT @ServerName + ' model DB recovery set to SIMPLE'
IF @Dev = 0 PRINT @ServerName + ' model DB recovery set to FULL'
GO
PRINT '******************************************************************************'
PRINT '04 END'
PRINT '******************************************************************************'
PRINT ''
PRINT '******************************'
PRINT '05 Create OHSU_sqltab database'
PRINT '******************************'
USE [master]
GO
Declare @Path varchar(500), @Sql nvarchar(max)
SELECT @Path = SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1 )
FROM master.sys.master_files
WHERE database_id = 1 AND file_id = 1
Set @Sql = 'CREATE DATABASE [ohsu_sqltab] ON PRIMARY ( NAME = N''ohsu_sqltab'', FILENAME =N' + 
QuoteName( @Path + 'ohsu_sqltab.mdf', '''' ) 
+ ' , SIZE = 50MB , FILEGROWTH = 200MB) ' +
' LOG ON ( NAME = N''ohsu_sqltab_log'', FILENAME = N''E:\MSSQL\ohsu_sqltab.ldf'' '
+ ' , SIZE = 20MB , FILEGROWTH = 200MB) '
Exec( @Sql )
--Always set ohsu_sqltabl to RECOVERY SIMPLE
ALTER DATABASE ohsu_sqltab SET RECOVERY SIMPLE
PRINT 'ohsu_sqltab database created'

--Set ohsu_sqltab owner to SA
USE ohsu_sqltab
EXEC sp_changedbowner 'sa'
PRINT 'ohsu_sqltab db owner changed to SA'
GO

--Changing sqltab DB Owner to SA --added by VMJ on 20140625

PRINT '******************************'
PRINT '05 END'
PRINT '******************************'
PRINT ''
--Below are former contents of 12-RandomConfigs.sql
PRINT '********************'
PRINT '06 Enable remote DAC'
PRINT '********************'
-- added by O.Tsytsyn 12/17/2014

USE [master]
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure
GO
EXEC sp_configure 'remote admin connections', 1
GO
RECONFIGURE
GO
EXEC sp_configure
GO
PRINT '********************'
PRINT '06 END'
PRINT '********************'
PRINT ''
PRINT '******************************'
PRINT '07 Log only failed connections'
PRINT '******************************'
-- added by O.Tsytsyn 12/17/2014
USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'AuditLevel', REG_DWORD, 2
GO
PRINT '******************************'
PRINT '07 END'
PRINT '******************************'
PRINT ''
PRINT '************************************************************'
PRINT '08 Change ReportServer and ReportServerTempDB db owner to SA'
PRINT '************************************************************'
--added by VMJ on 20140821
DECLARE @dbname nvarchar(128)
DECLARE @sqlCommand varchar(1000)
SET @dbname = N'ReportServer'

IF (EXISTS (SELECT name 
FROM master.dbo.sysdatabases 
WHERE ('[' + name + ']' = @dbname 
OR name = @dbname)))

BEGIN
	SET @sqlCommand = 'USE ' + @dbname + ' EXEC sp_changedbowner ''sa''' 
	EXEC (@sqlCommand)
	PRINT 'ReportServer DB Owner changed to SA'
END

ELSE PRINT 'ReportServer DB does not exist on this server'

GO

DECLARE @dbname nvarchar(128)
DECLARE @sqlCommand varchar(1000)
SET @dbname = N'ReportServerTempDB'

IF (EXISTS (SELECT name 
FROM master.dbo.sysdatabases 
WHERE ('[' + name + ']' = @dbname 
OR name = @dbname)))

BEGIN
	SET @sqlCommand = 'USE ' + @dbname + ' EXEC sp_changedbowner ''sa''' 
	EXEC (@sqlCommand)
	PRINT 'ReportServerTempDB DB Owner changed to SA'
END

ELSE PRINT 'ReportServerTempDB does not exist on this server'
GO
PRINT '************************************************************'
PRINT '08 END'
PRINT '************************************************************'
PRINT ''
PRINT '******************************'
PRINT '09 Add OHSU_CycleErrorLogs job'
PRINT '******************************'
USE [msdb]
GO

/****** Object:  Job [OHSU_CycleErrorLogs]    Script Date: 1/14/2013 2:21:09 PM ******/
IF EXISTS (SELECT name FROM msdb.dbo.sysjobs WHERE name=N'OHSU_CycleErrorLogs')
	exec msdb.dbo.sp_delete_job @job_name=N'OHSU_CycleErrorLogs'
go


/****** Object:  Job [OHSU_CycleErrorLogs]    Script Date: 1/14/2013 2:21:09 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 1/14/2013 2:21:09 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'OHSU_CycleErrorLogs', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'20130114DO: Reycyle SQL Errror and Agent Error Logs', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBSQ', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cycle error log, if appropriate]    Script Date: 1/14/2013 2:21:09 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Cycle error log, if appropriate', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @sql_log table (
	LogDate datetime,
	ProcessInfo varchar(50),
	MsgTxt varchar(2000)
)

insert into @sql_log
exec xp_readerrorlog 0,1,''Logging SQL Server messages''

if ((select min(logdate) from @sql_log) < dateadd(ww, -1, getdate()))
	dbcc errorlog with no_infomsgs
	--EXEC msdb.dbo.sp_cycle_errorlog

go

	', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cycle agent log, if appropriate]    Script Date: 1/14/2013 2:21:09 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Cycle agent log, if appropriate', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- If the oldest record in the the current Agent Log is more than a week old, cycle the log
DECLARE @sql_log TABLE
    (
     LogDate DATETIME,
     ProcessInfo VARCHAR(50),
     MsgTxt VARCHAR(2000)
    )

INSERT  INTO @sql_log
        EXEC xp_readerrorlog 0, 2

IF ((SELECT MIN (LogDate) FROM @sql_log) < DATEADD(ww, -1, GETDATE()))
    EXEC msdb.dbo.sp_cycle_agent_errorlog
go

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Monthly log cycle check', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20091006, 
		@active_end_date=99991231, 
		@active_start_time=235958, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

PRINT '******************************'
PRINT '09 END'
PRINT '******************************'
PRINT ''

PRINT '*******************************************'
PRINT '------------- END MultiScript -------------'
PRINT '*******************************************'


