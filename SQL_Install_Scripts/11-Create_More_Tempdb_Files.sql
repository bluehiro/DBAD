/* ============================================= 
Create More TempDB Files - Standard OHSU SQL Server Install Scripts

WARNING: Do not just "run" this script, read the note below!

Note: Determine the number of server CPUs and create that many
tempDB files minus 1 (since 1 already exists). Matching the number
of files to the number of CPUs improves performance and makes 
long-term maintenance easier.

ChangeLog:
2015-08-27 VMJ - Initital Creation

============================================= */
USE master
GO


-- Size the original tempdb files
ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev, SIZE = 512 MB, FILEGROWTH = 512 MB)
GO
ALTER DATABASE tempdb MODIFY FILE (NAME = templog, SIZE = 512 MB, FILEGROWTH = 256 MB)
GO

DECLARE	@Path VARCHAR(300),
		@Sql NVARCHAR(MAX)


SELECT
	@Path = SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
FROM master.sys.master_files
WHERE database_id = 1
AND file_id = 1


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_1'' , FileName = ' + QUOTENAME(@Path + 'tempdev_1.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_2'' , FileName = ' + QUOTENAME(@Path + 'tempdev_2.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_3'' , FileName = ' + QUOTENAME(@Path + 'tempdev_3.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_4'' , FileName = ' + QUOTENAME(@Path + 'tempdev_4.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_5'' , FileName = ' + QUOTENAME(@Path + 'tempdev_5.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_6'' , FileName = ' + QUOTENAME(@Path + 'tempdev_6.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


SET @Sql = 'Alter Database [tempdb] Add File( Name = ''tempdev_7'' , FileName = ' + QUOTENAME(@Path + 'tempdev_7.ndf', '''')
+ ' , SIZE = 512MB , FILEGROWTH = 512MB)'
EXEC (@Sql)


