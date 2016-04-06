/* ============================================= 
Move Tempdb (optional OHSU script)

WARNING: Do not just "run" this script! Only use
it if you have been asked to migrate the tempdb
to a different drive.

ChangeLog:
2015-08-27 VMJ - Added tombstone and warning

============================================= */

--select * from sysfiles

--Determine the logical file names for the tempdb database.

USE tempdb
GO
EXEC sp_helpfile
GO

--The logical name for each file is contained in the NAME column.
--Change the location of each file using ALTER DATABASE.

USE master
GO
ALTER DATABASE tempdb 
MODIFY FILE (NAME = tempdev, FILENAME = 'E:SQLData\tempdb.mdf')
GO
ALTER DATABASE  tempdb 
MODIFY FILE (NAME = templog, FILENAME = 'E:SQLData\templog.ldf')
GO

--Stop the Instance of SQL Server
--move the files to their new location
--Restart the Instance of SQL Server
--Verify the file change:

SELECT name, physical_name AS CurrentLocation, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');
