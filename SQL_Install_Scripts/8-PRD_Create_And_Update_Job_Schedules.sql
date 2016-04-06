----- Creates and Updates Job Schedules for New and Existing SQL Installations -----
--20121218DO
--This script requires that the script be ran prior to this one:\\dbad03\Scripts\newMSSQL\New Scripts\8-Ola_MaintenanceSolution.sql

--20130716DO Major organization overhaul of the entire script
	--Created Proc DropJobSchedules
	--This script modifies the schedule for the following jobs:
		--For SQL 2008 and 2012	
			--IndexOptimize - USER_DATABASES
			--DatabaseIntegrityCheck - USER_DATABASES
			--DatabaseIntegrityCheck - SYSTEM_DATABASES
			--sp_delete_backuphistory
			--sp_purge_jobhistory
			--DatabaseBackup - USER_DATABASES - LOG
			--OHSU_Freespace_Report 
			--OHSU_databasesize
		--For SQL 2012 only
			--DatabaseBackup - SYSTEM_DATABASES - FULL
			--DatabaseBackup - USER_DATABASES - FULL

	--Also, sets all 2008R2 and 2012 to the same locations for all backups -
	--Also modifies the job email operator name to DBSQ
	--This script is now completely rerunable
	--20130712DO: Changed System Database backup from weekly to daily
		--Changed @Schedule_Name to @schedule_name to handle case sensitive boxes such as ACEYUSSQL01 and ACEYUSSQL02

	--20130904DO: Removed Script that modified job steps and put them into seperate File titled 9B-Create_And_Update_Job_Steps.sql
		--Renamed this files as 9A-Create_And_Update_Job_Schedules.sql

	--20141224DO Created this as the Production Script for Production systems that will backup Daily changed name from 9A-Create_And_Update_Job_Schedules.sql to 9A-Create_And_Update_Prod_Job_Schedules.sql
		--Removed the SQL2012 Only criteria from the following sections as the script will now be used for all versions of sql (2005 onward)
			--- Create Daily Schedule for DatabaseBackup - SYSTEM_DATABASES - FULL - For SQL 2012 Only ---
			--- Create Daily Schedule for DatabaseBackup - USER_DATABASES - FULL - For SQL 2012 Only ---

	--20150521DO Added "Create Weekly Schedule for Output File Cleanup"
------------------------------------------------------


----- Create Drop Procedure -----
USE ohsu_sqltab
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DropJobSchedules]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DropJobSchedules]
GO
/****** Object:  StoredProcedure [dbo].[CommandExecute]    Script Date: 7/18/2013 12:25:55 PM ******/
CREATE PROCEDURE [dbo].[DropJobSchedules]
@JobName nvarchar(max)
AS
BEGIN
---- Drop All Job Schedules with just the Job Name ----
---- Created 20130718DO	
---- Run statement example: EXEC ohsu_sqltab.dbo.DropJobSchedules 'IndexOptimize - USER_DATABASES'
	Declare @SCID INT
		--Declare @JobName nvarchar(128)
		--Select @JobName = 'DatabaseBackup - SYSTEM_DATABASES - FULL'
	-- Loop and Drop --
		While (Select count(*)
			FROM msdb.dbo.sysschedules 
			LEFT JOIN msdb.dbo.sysjobschedules ON msdb.dbo.sysjobschedules.schedule_id = msdb.dbo.sysschedules.schedule_id 
			LEFT JOIN msdb.dbo.sysjobs ON msdb.dbo.sysjobschedules.job_id = msdb.dbo.sysjobs.job_id
			Where sysjobs.name = @JobName) != 0 
		Begin
			Select @SCID = (select top 1 sysschedules.schedule_id
			FROM msdb.dbo.sysjobs
			LEFT OUTER JOIN msdb.dbo.sysjobschedules ON msdb.dbo.sysjobschedules.job_id = msdb.dbo.sysjobs.job_id
			LEFT OUTER JOIN msdb.dbo.sysschedules ON msdb.dbo.sysjobschedules.schedule_id = msdb.dbo.sysschedules.schedule_id 
			Where sysjobs.name = @JobName)

			--select @JobName, @SCID
			EXEC msdb.dbo.sp_delete_schedule
			@schedule_id = @SCID
			,@force_delete = 1
		End

	-- /Drop All Schedule with just the Job Name --
END
GO


USE Master
GO


----- Schedule Weekly Sequential Jobs -----
--Run thes every week on the weekend as any time.  So anytime Saturday and Sunday only, and in general sequence.

--Determine the inital start time
	--Generate time and Run the Index Optimize
	--90 min later run the DatabaseIntegrityCheck - USER_DATABASES
	--60 min later run the DatabaseIntegrityCheck - SYSTEM_DATABASES
	--60 min later run the sp_delete_backuphistory
	--60 min later run the sp_purge_jobhistory
--4.5 hour run time spread for these jobs
--Time Examples
	--03000 12:30am
	--30000 3am
	--40000 4am

--Generate Initial Time for Index Optimize
DECLARE 
	@StartTime time(0)
  ,@HourInterval INT
	,@MinInterval INT
	,@HighestHour INT
	,@LowestHour INT
	,@HighestMin INT
	,@LowestMin INT
	,@IndOpt_StartTime INT
	,@ICUDB_StartTime INT
	,@ICSDB_StartTime INT
	,@SPBH_StartTime INT
	,@SPJH_StartTime INT
	,@DayOfWeek INT


---- Set Value Limits --
SELECT @StartTime = '00:00:00'
SELECT @LowestHour = 0 ---- The lowest random number
SELECT @LowestMin = 0 ---- The lowest random number
SELECT @HighestMin = 59 ---- The highest random number
SELECT @HighestHour = 24 - 5 ---- The highest random number

--- Set Hour ---
SELECT @HourInterval = ROUND(((@HighestHour - @LowestHour -1) * RAND() + @LowestHour), 0)

--- Set Min ---
SELECT @MinInterval = ROUND(((@HighestMin - @LowestMin -1) * RAND() + @LowestMin), 0)
SELECT @StartTime = DATEADD(hh, @HourInterval, @StartTime)
SELECT @StartTime = DATEADD(mi, @MinInterval, @StartTime)

--- Set Day of Week ---
SELECT @DayOfWeek = 
	Case	WHEN @MinInterval < 30 then 1
				WHEN @MinInterval >=30 then 64
	End

--Select @DayOfWeek as DayOfWeek, @HourInterval as HourInterval, @MinInterval as MinInterval 

--- Set Job schedules at correct intervals---
SELECT @IndOpt_StartTime = REPLACE(@StartTime, ':', '') 
SELECT @StartTime = DATEADD(mi, 90, @StartTime)
SELECT @ICUDB_StartTime = REPLACE(@StartTime, ':', '')
SELECT @StartTime = DATEADD(mi, 60, @StartTime)
SELECT @ICSDB_StartTime = REPLACE(@StartTime, ':', '')
SELECT @StartTime = DATEADD(mi, 60, @StartTime)
SELECT @SPBH_StartTime = REPLACE(@StartTime, ':', '')
SELECT @StartTime = DATEADD(mi, 60, @StartTime)
SELECT @SPJH_StartTime = REPLACE(@StartTime, ':', '')

/*
SELECT  @StartTime as StartTime
	,@IndOpt_StartTime as IndOpt_StartTime
	,@ICUDB_StartTime as ICUDB_StartTime
	,@ICSDB_StartTime as ICSDB_StartTime
	,@SPBH_StartTime as SPBH_StartTime
	,@SPJH_StartTime as SPJH_StartTime
*/

/*--- Day of week ---
	@freq_interval=32, friday
	@freq_interval=64, --saturday
	@freq_interval=1, --Sunday
--- /Day of week ---*/

DECLARE @ReturnCode INT
 SELECT @ReturnCode = 0

 
-- IndexOptimize - USER_DATABASES --
--Start at 12:30ish
-- Drop all job Schedules
	EXEC ohsu_sqltab.dbo.DropJobSchedules 'IndexOptimize - USER_DATABASES'
-- Create new Schedule
	EXEC @ReturnCode = msdb.dbo.sp_add_schedule
		@schedule_name=N'IndexOptimize - USER_DATABASES - Weekly', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval= @DayOfWeek, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121127, 
		@active_end_date=99991231, 
		@active_start_time=@IndOpt_StartTime,
		@active_end_time=235959

	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'IndexOptimize - USER_DATABASES',
		@schedule_name = N'IndexOptimize - USER_DATABASES - Weekly'
	

-- DatabaseIntegrityCheck - USER_DATABASES --
-- Run at 3:00am
-- Drop all job Schedules
	EXEC ohsu_sqltab.dbo.DropJobSchedules 'DatabaseIntegrityCheck - USER_DATABASES'
-- Create new Schedule
	EXEC @ReturnCode = msdb.dbo.sp_add_schedule 
		@schedule_name=N'DatabaseIntegrityCheck - USER_DATABASES - Weekly', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval= @DayOfWeek, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121127, 
		@active_end_date=99991231, 
		@active_start_time=@ICUDB_StartTime, 
		@active_end_time=235959

	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'DatabaseIntegrityCheck - USER_DATABASES',
		@schedule_name = N'DatabaseIntegrityCheck - USER_DATABASES - Weekly'


-- DatabaseIntegrityCheck - SYSTEM_DATABASES --
-- Run at 4:00am
-- Drop all job Schedules
	EXEC ohsu_sqltab.dbo.DropJobSchedules 'DatabaseIntegrityCheck - SYSTEM_DATABASES'
-- Create new Schedule
	EXEC @ReturnCode = msdb.dbo.sp_add_schedule 
		@schedule_name=N'DatabaseIntegrityCheck - SYSTEM_DATABASES - Weekly', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval= @DayOfWeek, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121127, 
		@active_end_date=99991231, 
		@active_start_time=@ICSDB_StartTime, 
		@active_end_time=235959 

	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'DatabaseIntegrityCheck - SYSTEM_DATABASES',
		@schedule_name = N'DatabaseIntegrityCheck - SYSTEM_DATABASES - Weekly'


-- sp_delete_backuphistory --
-- Run at 5:00am
-- Drop all job Schedules
	EXEC ohsu_sqltab.dbo.DropJobSchedules 'sp_delete_backuphistory'
-- Create new Schedule
	EXEC @ReturnCode = msdb.dbo.sp_add_schedule 
		@schedule_name=N'sp_delete_backuphistory - Weekly', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval= @DayOfWeek, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121127, 
		@active_end_date=99991231, 
		@active_start_time=@SPBH_StartTime, 
		@active_end_time=235959 
		
	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'sp_delete_backuphistory',
		@schedule_name = N'sp_delete_backuphistory - Weekly'


	
-- sp_purge_jobhistory --
-- Run at 6:00am
-- Drop all job Schedules
	EXEC ohsu_sqltab.dbo.DropJobSchedules 'sp_purge_jobhistory'
-- Create new Schedule
	EXEC @ReturnCode = msdb.dbo.sp_add_schedule 
		@schedule_name=N'sp_purge_jobhistory - Weekly', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval= @DayOfWeek, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121127, 
		@active_end_date=99991231, 
		@active_start_time=@SPJH_StartTime, 
		@active_end_time=235959 
		
	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'sp_purge_jobhistory',
		@schedule_name = N'sp_purge_jobhistory - Weekly'


----- /Schedule Weekly Sequential Jobs -----











----- Log Recursion - Hourly -----

-- DatabaseBackup - USER_DATABASES - LOG --
-- Run every 15 to 45 min Daily
DECLARE @Int INT
DECLARE @UpperInt INT;
DECLARE @LowerInt INT
DECLARE @ReturnCode2 INT
 SELECT @ReturnCode2 = 0

---- Set Value Limits
SET @LowerInt = 15 ---- The lowest random number
SET @UpperInt = 45 ---- The highest random number
SELECT @Int = ROUND(((@UpperInt - @LowerInt -1) * RAND() + @LowerInt), 0)

--SELECT @Int
-- Drop all job Schedules
	EXEC ohsu_sqltab.dbo.DropJobSchedules 'DatabaseBackup - USER_DATABASES - LOG'
-- Create new Schedule
EXEC @ReturnCode2 = msdb.dbo.sp_add_schedule --@job_id=@jobId,
    @schedule_name=N'DatabaseBackup - USER_DATABASES - LOG - Hourly',
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=@Int,
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20121218, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959

EXEC msdb.dbo.sp_attach_schedule
  @job_name = N'DatabaseBackup - USER_DATABASES - LOG',
  @schedule_name = N'DatabaseBackup - USER_DATABASES - LOG - Hourly'


	



----- OHSU_Freespace_Report and OHSU_databasesize -----
	--The default in 3-OHSU4.sql and 3-OHSU5.sql are both daily at 10:00am which all SQL servers are set at.
	--This script adjusts that time to a random value
	--Run between 7 and 10am

--DECLARE 
--	@OHSU_StartTime time(0)
--  ,@OHSU_HourInterval INT
--	,@OHSU_MinInterval INT
--	,@OHSU_HighestHour INT
--	,@OHSU_LowestHour INT
--	,@OHSU_HighestMin INT
--	,@OHSU_LowestMin INT
--	,@OHSU_FreeSpace_StartTime INT
--	,@OHSU_DbSize_StartTime INT
--  ,@ReturnCode3 INT

--SELECT @ReturnCode3 = 0


------ Set Value Limits --
--SELECT @OHSU_StartTime = '00:00:00'
--SELECT @OHSU_LowestHour = 7 ---- The lowest random number
--SELECT @OHSU_HighestHour = 10 ---- The highest random number
--SELECT @OHSU_LowestMin = 0 ---- The lowest random number
--SELECT @OHSU_HighestMin = 59 ---- The highest random number

----- Set Hour ---
--SELECT @OHSU_HourInterval = ROUND(((@OHSU_HighestHour - @OHSU_LowestHour -1) * RAND() + @OHSU_LowestHour), 0)

----- Set Min ---
--SELECT @OHSU_MinInterval = ROUND(((@OHSU_HighestMin - @OHSU_LowestMin -1) * RAND() + @OHSU_LowestMin), 0)
--SELECT @OHSU_StartTime = DATEADD(hh, @OHSU_HourInterval, @OHSU_StartTime)
--SELECT @OHSU_StartTime = DATEADD(mi, @OHSU_MinInterval, @OHSU_StartTime)

----Select @OHSU_HourInterval as HourInterval, @OHSU_MinInterval as MinInterval 

----- Set Job schedules at correct intervals---
--SELECT @OHSU_FreeSpace_StartTime = REPLACE(@OHSU_StartTime, ':', '') 
--SELECT @OHSU_StartTime = DATEADD(mi, 0, @OHSU_StartTime) --Change 0 to the desired time difference between the two schedules
--SELECT @OHSU_DbSize_StartTime = REPLACE(@OHSU_StartTime, ':', '')

----SELECT @OHSU_FreeSpace_StartTime, @OHSU_DbSize_StartTime

---- OHSU_Freespace_Report --	
---- Drop all job Schedules
--	EXEC ohsu_sqltab.dbo.DropJobSchedules 'OHSU_Freespace_Report'
---- Create new Schedule

--EXEC @ReturnCode3 = msdb.dbo.sp_add_schedule --@job_id=@jobId,
--  @schedule_name=N'OHSU_Freespace_Report - Daily', 
--	@enabled=1, 
--	@freq_type=4, 
--	@freq_interval=1, 
--	@freq_subday_type=1, 
--	@freq_subday_interval=0, 
--	@freq_relative_interval=0, 
--	@freq_recurrence_factor=0, 
--	@active_start_date=20040831, 
--	@active_end_date=99991231, 
--	@active_start_time=@OHSU_FreeSpace_StartTime, 
--	@active_end_time=235959

--EXEC msdb.dbo.sp_attach_schedule
--  @job_name = N'OHSU_Freespace_Report',
--  @schedule_name = N'OHSU_Freespace_Report - Daily'

---- OHSU_databasesize --
--IF EXISTS (Select	* From msdb.dbo.sysschedules Where	name = N'OHSU_Databasesize')
--	BEGIN
--			EXEC msdb.dbo.sp_delete_schedule
--			@schedule_name = N'OHSU_Databasesize', 
--			@force_delete = 1
--	END

--EXEC @ReturnCode3 = msdb.dbo.sp_add_schedule --@job_id=@jobId,
--  @schedule_name=N'OHSU_Databasesize', 
--	@enabled=1, 
--	@freq_type=4, 
--	@freq_interval=1, 
--	@freq_subday_type=1, 
--	@freq_subday_interval=0, 
--	@freq_relative_interval=0, 
--	@freq_recurrence_factor=0, 
--	@active_start_date=20040831, 
--	@active_end_date=99991231, 
--	@active_start_time=@OHSU_DbSize_StartTime, 
--	@active_end_time=235959 

--EXEC msdb.dbo.sp_attach_schedule
--  @job_name = N'OHSU_Databasesize',
--  @schedule_name = N'OHSU_Databasesize'


----- /OHSU_Freespace_Report and OHSU_databasesize -----






--- Create Daily Schedule for DatabaseBackup - SYSTEM_DATABASES - FULL ---

	DECLARE 
		@StartTime_SDFD time(0)
		,@HourInterval_SDFD INT
		,@MinInterval_SDFD INT
		,@HighestHour_SDFD INT
		,@LowestHour_SDFD INT
		,@HighestMin_SDFD INT
		,@LowestMin_SDFD INT
		,@Schedule_StartTime_SDFD INT
		,@DayOfWeek_SDFD INT
		,@ReturnCode_SDFD INT
		,@JobStartDate_SDFD varchar(10)
	SELECT @ReturnCode_SDFD = 0

	-- Set Value Limits --
	SELECT @StartTime_SDFD = '00:00:00'
	SELECT @LowestHour_SDFD = 18 ---- The lowest random number
	SELECT @HighestHour_SDFD = 22 ---- The highest random number
	SELECT @LowestMin_SDFD = 0 ---- The lowest random number
	SELECT @HighestMin_SDFD = 59 ---- The highest random number
	SELECT @JobStartDate_SDFD = convert(varchar,getdate(),112) -- Set the job start date

	-- Set Hour --
	SELECT @HourInterval_SDFD = ROUND(((@HighestHour_SDFD - @LowestHour_SDFD -1) * RAND() + @LowestHour_SDFD), 0)

	-- Set Min --
	SELECT @MinInterval_SDFD = ROUND(((@HighestMin_SDFD - @LowestMin_SDFD -1) * RAND() + @LowestMin_SDFD), 0)

	-- Add to create the time --
	SELECT @StartTime_SDFD = DATEADD(hh, @HourInterval_SDFD, @StartTime_SDFD)
	SELECT @StartTime_SDFD = DATEADD(mi, @MinInterval_SDFD, @StartTime_SDFD)

	-- Set Job schedules at correct intervals --
	SELECT @Schedule_StartTime_SDFD = REPLACE(@StartTime_SDFD, ':', '') 

	--Select @DayOfWeek as DayOfWeek, @HourInterval as HourInterval, @MinInterval as MinInterval, @Schedule_StartTime as Schedule_StartTime

	-- Drop all job Schedules
		EXEC ohsu_sqltab.dbo.DropJobSchedules 'DatabaseBackup - SYSTEM_DATABASES - FULL'
	-- Create new Schedule
	
	-- Make new Schedule --
	EXEC @ReturnCode_SDFD = msdb.dbo.sp_add_schedule --@job_id=@jobId,
		@schedule_name=N'DatabaseBackup - SYSTEM_DATABASES - FULL - Daily', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=@JobStartDate_SDFD,
		@active_end_date=99991231, 
		@active_start_time=@Schedule_StartTime_SDFD,
		@active_end_time=235959

	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'DatabaseBackup - SYSTEM_DATABASES - FULL',
		@schedule_name = N'DatabaseBackup - SYSTEM_DATABASES - FULL - Daily'

--- /Create Daily Schedule for DatabaseBackup - SYSTEM_DATABASES - FULL ---




--- Create Daily Schedule for DatabaseBackup - USER_DATABASES - FULL ---

	DECLARE 
		@StartTime_UDFD time(0)
		,@HourInterval_UDFD INT
		,@MinInterval_UDFD INT
		,@HighestHour_UDFD INT
		,@LowestHour_UDFD INT
		,@HighestMin_UDFD INT
		,@LowestMin_UDFD INT
		,@Schedule_StartTime_UDFD INT
		,@ReturnCode_UDFD INT
		,@JobStartSate_UDFD varchar(10)
	SELECT @ReturnCode_UDFD = 0

	-- Set Value Limits --
	SELECT @StartTime_UDFD = '00:00:00'
	SELECT @LowestHour_UDFD = 17 ---- The lowest random number
	SELECT @HighestHour_UDFD = 22 ---- The highest random number
	SELECT @LowestMin_UDFD = 0 ---- The lowest random number
	SELECT @HighestMin_UDFD = 59 ---- The highest random number
	SELECT @JobStartSate_UDFD = convert(varchar,getdate(),112) -- Set the job start date

	-- Set Hour --
	SELECT @HourInterval_UDFD = ROUND(((@HighestHour_UDFD - @LowestHour_UDFD -1) * RAND() + @LowestHour_UDFD), 0)

	-- Set Min --
	SELECT @MinInterval_UDFD = ROUND(((@HighestMin_UDFD - @LowestMin_UDFD -1) * RAND() + @LowestMin_UDFD), 0)

	-- Add to create the time --
	SELECT @StartTime_UDFD = DATEADD(hh, @HourInterval_UDFD, @StartTime_UDFD)
	SELECT @StartTime_UDFD = DATEADD(mi, @MinInterval_UDFD, @StartTime_UDFD)

	-- Set Job schedules at correct intervals --
	SELECT @Schedule_StartTime_UDFD = REPLACE(@StartTime_UDFD, ':', '') 

--	Select @HourInterval_UDFD as HourInterval, @MinInterval_UDFD as MinInterval, @Schedule_StartTime_UDFD as Schedule_StartTime

	-- Drop all job Schedules
		EXEC ohsu_sqltab.dbo.DropJobSchedules 'DatabaseBackup - USER_DATABASES - FULL'
	-- Create new Schedule
	
	-- Make new Schedule --
	EXEC @ReturnCode_UDFD = msdb.dbo.sp_add_schedule --@job_id=@jobId,
		@schedule_name=N'DatabaseBackup - USER_DATABASES - FULL - Daily', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=@JobStartSate_UDFD,
		@active_end_date=99991231, 
		@active_start_time=@Schedule_StartTime_UDFD,
		@active_end_time=235959

	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'DatabaseBackup - USER_DATABASES - FULL',
		@schedule_name = N'DatabaseBackup - USER_DATABASES - FULL - Daily'

--- /Create Daily Schedule for DatabaseBackup - USER_DATABASES - FULL ---



--- Create Weekly Schedule for Output File Cleanup ---
	DECLARE 
		@StartTime_OFC time(0)
		,@HourInterval_OFC INT
		,@MinInterval_OFC INT
		,@HighestHour_OFC INT
		,@LowestHour_OFC INT
		,@HighestMin_OFC INT
		,@LowestMin_OFC INT
		,@Schedule_StartTime_OFC INT
		,@DayOfWeek_OFC INT
		,@ReturnCode_OFC INT
		,@JobStartDate_OFC varchar(10)
	SELECT @ReturnCode_OFC = 0

	-- Set Value Limits --
	SELECT @StartTime_OFC = '00:00:00'
	SELECT @LowestHour_OFC = 01 ---- The lowest random number
	SELECT @HighestHour_OFC = 22 ---- The highest random number
	SELECT @LowestMin_OFC = 0 ---- The lowest random number
	SELECT @HighestMin_OFC = 59 ---- The highest random number
	SELECT @JobStartDate_OFC = convert(varchar,getdate(),112) -- Set the job start date

	-- Set Hour --
	SELECT @HourInterval_OFC = ROUND(((@HighestHour_OFC - @LowestHour_OFC -1) * RAND() + @LowestHour_OFC), 0)

	-- Set Min --
	SELECT @MinInterval_OFC = ROUND(((@HighestMin_OFC - @LowestMin_OFC -1) * RAND() + @LowestMin_OFC), 0)

	-- Add to create the time --
	SELECT @StartTime_OFC = DATEADD(hh, @HourInterval_OFC, @StartTime_OFC)
	SELECT @StartTime_OFC = DATEADD(mi, @MinInterval_OFC, @StartTime_OFC)

	-- Set Day of Week --
	SELECT @DayOfWeek_OFC = 
		Case	WHEN @MinInterval_OFC < 30 then 1
					WHEN @MinInterval_OFC >=30 then 64
		End

	/*-- Day of week --
		@freq_interval=32, --Friday
		@freq_interval=64, --Saturday
		@freq_interval=1, --Sunday
	-- /Day of week --*/

	-- Set Job schedules at correct intervals --
	SELECT @Schedule_StartTime_OFC = REPLACE(@StartTime_OFC, ':', '') 

	--Select @DayOfWeek_OFC as DayOfWeek, @HourInterval_OFC as HourInterval, @MinInterval_OFC as MinInterval, @Schedule_StartTime_OFC as Schedule_StartTime

	-- Drop all job Schedules
		EXEC ohsu_sqltab.dbo.DropJobSchedules 'Output File Cleanup'
	-- Create new Schedule
	
	-- Make new Schedule --
	EXEC @ReturnCode_OFC = msdb.dbo.sp_add_schedule --@job_id=@jobId,
		@schedule_name=N'Output File Cleanup', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval= @DayOfWeek_OFC, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=@JobStartDate_OFC,
		@active_end_date=99991231, 
		@active_start_time=@Schedule_StartTime_OFC,
		@active_end_time=235959

	EXEC msdb.dbo.sp_attach_schedule
		@job_name = N'Output File Cleanup',
		@schedule_name = N'Output File Cleanup'


--- /Create Weekly Schedule for Output File Cleanup ---


----- Update the job email operator name to DBSQ -----
--20130313DO
--More job names can be added if needed.  Script will not fail if Job Name is not found.
USE [msdb]

DECLARE @JobID_1 nvarchar(200)
DECLARE @JobList as table (
	JobName nvarchar(200)
	,JobId nvarchar(200))

Insert @JobList
Select name, job_id FROM msdb.dbo.sysjobs WHERE [name] in
('DatabaseBackup - SYSTEM_DATABASES - FULL'
,'DatabaseBackup - USER_DATABASES - DIFF'
,'DatabaseBackup - USER_DATABASES - FULL'
,'DatabaseBackup - USER_DATABASES - LOG'
,'DatabaseIntegrityCheck - SYSTEM_DATABASES'
,'DatabaseIntegrityCheck - USER_DATABASES'
,'IndexOptimize - USER_DATABASES'
,'sp_delete_backuphistory'
,'sp_purge_jobhistory'
,'Output File Cleanup'
,'CommandLog Cleanup'
,'syspolicy_purge_history'
,'OHSU_Databasesize'
,'OHSU_Freespace_Report'
,'OHSU_CycleErrorLogs')
--Select * from @JobList

WHILE(Select count(*) from @JobList) > 0
	Begin
		Select @JobID_1 = Min(JobId) from @JobList
		--Select @JobID_1
		--Update
			EXEC msdb.dbo.sp_update_job @job_id=@JobID_1, 
			@notify_level_email=2, 
			@notify_level_netsend=2, 
			@notify_level_page=2, 
			@notify_email_operator_name=N'DBSQ'
		Delete from @JobList where JobID =@JobID_1
	End

----- /Update the job email operator name to DBSQ -----



----- Drop Schedules or Clean Up Duplicates -----
/*

-- List and remove with schedule_id --
Use msdb;
Go
Select	*
From	 msdb.dbo.sysschedules
Where	name = 'DatabaseIntegrityCheck - USER_DATABASES - Weekly'

-- Individual Delete Statement
EXEC msdb.dbo.sp_delete_schedule
@schedule_id = 65,
@force_delete = 1


--Or list the duplicates
Select *
From  msdb.dbo.sysschedules
Where	name in (
	Select	Name
	From	 msdb.dbo.sysschedules
	Group by Name
	Having count(*) >1)


--Or just list the delete statements  --Just run this one!
Select 'EXEC msdb.dbo.sp_delete_schedule @schedule_id = ' + convert(varchar,schedule_id) + ', @force_delete = 1'
From  msdb.dbo.sysschedules
Where	name in (
	Select	Name
	From	 msdb.dbo.sysschedules
	Group by Name
	Having count(*) >1)
*/


----- /Drop Schedules or Clean Up Duplicates -----


PRINT 'PRD - Ola Job Schedules Created & Updated'