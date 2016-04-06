
 
use msdb
go

exec msdb.dbo.sp_syscollector_update_collection_item
@name='Disk Usage - Data Files'
,@frequency=21600

exec msdb.dbo.sp_syscollector_update_collection_item
@name = 'Disk Usage - Log Files'
,@frequency=21600

exec msdb.dbo.sp_syscollector_update_collection_item
@name = 'Server Activity - DMV Snapshots'
,@frequency=3600

exec msdb.dbo.sp_syscollector_update_collection_item
@name = 'Server Activity - Performance Counters'
,@frequency=3600

exec msdb.dbo.sp_syscollector_update_collection_item
@name = 'Utility Information - Managed Instance'
,@frequency=3600

exec msdb.dbo.sp_syscollector_update_collection_item
@name = 'Query Statistics - Query Activity'
,@frequency=3600

exec msdb.dbo.sp_syscollector_update_collection_set
@name='Disk Usage'
,@days_until_expiration = 45 --DV20140909: changed from 90

exec msdb.dbo.sp_syscollector_update_collection_set
@name='Server Activity'
,@days_until_expiration = 10

exec msdb.dbo.sp_syscollector_update_collection_set
@name='Query Statistics'
,@days_until_expiration = 10



-- 20140910DO: Added the following two new collection sets --
-- Custom Collections for version 2012 and 2014 --
IF CHARINDEX ('11.0',@@version)>0 or CHARINDEX ('12.0',@@version)>0
BEGIN
 
-- Stored Procedure Usage Analysis --
	-- Change from the default 900 to 3600
	exec msdb.dbo.sp_syscollector_update_collection_item
	@name='Stored Procedure Usage Statistics'
	,@frequency=3600

	-- Change Retention from 30 days to 15 --
	exec msdb.dbo.sp_syscollector_update_collection_set
	@name='Stored Procedure Usage Analysis'
	,@days_until_expiration = 15



-- Table Usage Analysis --
-- Stored Procedure Usage Analysis --
	-- Change from the default 900 to 3600
	exec msdb.dbo.sp_syscollector_update_collection_item
	@name='Table Usage Statistics'
	,@frequency=3600

	exec msdb.dbo.sp_syscollector_update_collection_item
	@name='Transaction Statistics'
	,@frequency=3600

	-- Change Retention from 30 days to 15 --
	exec msdb.dbo.sp_syscollector_update_collection_set
	@name='Table Usage Analysis'
	,@days_until_expiration = 15

END

-- /20140910DO: Added the following two new collection sets --