
----- Creates and Updates Job Steps for New and Existisng SQL Installations -----
--20130903DO
--This script updates the job steps to log to table and backup to the new shares ---
--This script requires that the script be ran prior to this one:\\dbad03\Scripts\newMSSQL\New Scripts\8-Ola_MaintenanceSolution.sql
--script is dependent on SQL version as older versions (before 2008R2) cannot compress backups
--20130716DO: Updated all timings to 3 days (72 hours) and changed Log backups to 21 days (504 hours)
--20141118DO: Updated Path from NetApp to EMC Networker
	-- Originally: \\ohsu.edu\share\APP\SQL\SQLBACKUPS
	-- Now: \\msbdd1b\SQLBackup

--20141224 --Removed the version check (IF CHARINDEX ('11.0',@@version)>0 or CHARINDEX ('10.5',@@version)>0) and seperated out logs for no compression on SQL2008
		----- Set all 2008R2 and 2012 to the same locations for all backups with Compression -----
		----- Set all 2008 or Earlier to the same locations for all backups without Compression -----

--20141226 Created a Development version - 
	--Backs up weekly
--20141231DO: Changed database name "OHSU_SQLTAB" to "ohsu_sqltab" for case specific collations like those on ACEYUSSQL01 and ACEYUSSQL02 
--20150514DO: Added Retry attempts (2) and Retry intervals (2) minutes


----- Set all Prod Versions of SQL to the same locations for all backups without Compression -----
DECLARE @JobID nvarchar(200)
		Select @JobID = job_id FROM msdb.dbo.sysjobs WHERE [name] = 'DatabaseBackup - SYSTEM_DATABASES - FULL'
			EXEC msdb.dbo.sp_update_jobstep @job_id=@JobID, @step_id=1 , 
					@command=N'IF %date:~7,2% LEQ 7 (sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''SYSTEM_DATABASES'', @Directory = N''\\msbdd1b\msb_sql\Dev\Monthly'', @BackupType = ''FULL'', @Verify = ''N'', @CopyOnly = ''N'', @Compress = ''N'', @CleanupTime = 9672, @CheckSum = ''Y'', @LogToTable = ''Y''" -b) ELSE (sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''SYSTEM_DATABASES'', @Directory = N''\\msbdd1b\msb_sql\Dev\Weekly'', @BackupType = ''FULL'', @Verify = ''Y'', @CopyOnly = ''N'', @Compress = ''N'', @CleanupTime = 2184, @CheckSum = ''Y'', @LogToTable = ''Y''" -b)'
					,@retry_attempts=2
					,@retry_interval=2

		Select @JobID = job_id FROM msdb.dbo.sysjobs WHERE [name] = 'DatabaseBackup - USER_DATABASES - DIFF'
			EXEC msdb.dbo.sp_update_jobstep @job_id=@JobID, @step_id=1 , 
					@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''\\msbdd1b\msb_sql\Dev\Daily'', @BackupType = ''DIFF'', @Verify = ''Y'', @Compress = ''N'', @CleanupTime = 504, @CheckSum = ''Y'', @LogToTable = ''Y''" -b'
					,@retry_attempts=2
					,@retry_interval=2

		Select @JobID = job_id FROM msdb.dbo.sysjobs WHERE [name] = 'DatabaseBackup - USER_DATABASES - FULL'
			EXEC msdb.dbo.sp_update_jobstep @job_id=@JobID, @step_id=1 , 
					@command=N'IF %date:~7,2% LEQ 7 (sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''\\msbdd1b\msb_sql\Dev\Monthly'', @BackupType = ''FULL'', @Verify = ''N'', @CopyOnly = ''N'', @Compress = ''N'', @CleanupTime = 9672, @CheckSum = ''Y'', @LogToTable = ''Y''" -b) ELSE (sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''\\msbdd1b\msb_sql\Dev\Weekly'', @BackupType = ''FULL'', @Verify = ''Y'', @CopyOnly = ''N'', @Compress = ''N'', @CleanupTime = 2184, @CheckSum = ''Y'', @LogToTable = ''Y''" -b)'
					,@retry_attempts=2
					,@retry_interval=2
			

----- Logs -- Do not compress SQL2008 or earlier -----
--- /Set all 2008R2 and 2012 and 2014 to the same locations for all backups with Compression ---
IF CHARINDEX ('12.0',@@version)>0 or CHARINDEX ('11.0',@@version)>0 or CHARINDEX ('10.5',@@version)>0 
BEGIN
	Select @JobID = job_id FROM msdb.dbo.sysjobs WHERE [name] = 'DatabaseBackup - USER_DATABASES - LOG'
			EXEC msdb.dbo.sp_update_jobstep @job_id=@JobID, @step_id=1 , 
					@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''\\ohsu.edu\share\APP\SQL\SQLLOGS'', @BackupType = ''LOG'', @Verify = ''Y'', @Compress = ''Y'', @CleanupTime = 504, @CheckSum = ''Y'', @LogToTable = ''Y''" -b'
	END

--- /Set all 2008R2 and 2012 and 2014 to the same locations for all backups with Compression ---
----- Set all 2008 or Earlier to the same locations for all backups without Compression -----
ELSE
	
	BEGIN
		Select @JobID = job_id FROM msdb.dbo.sysjobs WHERE [name] = 'DatabaseBackup - USER_DATABASES - LOG'
			EXEC msdb.dbo.sp_update_jobstep @job_id=@JobID, @step_id=1 , 
					@command=N'sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = ''USER_DATABASES'', @Directory = N''\\ohsu.edu\share\APP\SQL\SQLLOGS'', @BackupType = ''LOG'', @Verify = ''Y'', @Compress = ''N'', @CleanupTime = 504, @CheckSum = ''Y'', @LogToTable = ''Y''" -b'
				--sqlcmd -E -S $(ESCAPE_SQUOTE(SRVR)) -d ohsu_sqltab -Q "EXECUTE [dbo].[DatabaseBackup] @Databases = 'USER_DATABASES', @Directory = N'\\ohsu.edu\share\APP\SQL\SQLLOGS', @BackupType = 'LOG', @Verify = 'Y', @Compress = 'Y',@CleanupTime = 72, @CheckSum = 'Y', @LogToTable = 'Y'" -b
	END

PRINT 'DEV - Ola Job Steps Created'