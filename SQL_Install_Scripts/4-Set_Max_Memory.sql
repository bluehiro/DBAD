/*
SQL Server loves memory and may fail to leave enough for the OS (or, heaven-forbid, 
an application running on the database server)
Setting a SQL's max memory value ensures everyone's got enough memory to function, 
and an 80% max is a good general guideline. (For some more specific suggestions, see below)

To see the current server memory, max memory and settings run only the SQL above the line; 
run it all to reset Max Memory
*/

-- Pull system info into a table variable
DECLARE @system_info TABLE (
	[Index]	int,
	[Name]	varchar(255),
	Internal_Value	int,
	Character_Value	varchar(255)
)
INSERT INTO @system_info EXEC master..xp_msver

-- Display available memory and current max memory setting in SQL
DECLARE @total_server_mem int, @sql_server_mem int, @os_percent_mem decimal(4,2)

SET @os_percent_mem = 0.2	-- % of memory to reserve for OS and apps
SET @total_server_mem = (select Internal_Value from @system_info where Name = 'PhysicalMemory')
SET @sql_server_mem = (select Internal_Value * (1.00 - @os_percent_mem) from @system_info where Name = 'PhysicalMemory')

SELECT @total_server_mem 'total mem', @os_percent_mem '% target os mem', @sql_server_mem 'target sql max mem', value 'current sql max mem' FROM sys.configurations WHERE name = 'max server memory (MB)'

/*********************************************************************************************/

-- If max memory isn't already set at n% of available memory, update it
IF (SELECT value FROM sys.configurations WHERE name = 'max server memory (MB)') <> @sql_server_mem
BEGIN
	exec sp_configure 'show advanced options', 1
	RECONFIGURE
	exec sp_configure 'max server memory (MB)', @sql_server_mem
	RECONFIGURE;
	exec sp_configure 'show advanced options', 0
	RECONFIGURE
END
ELSE
	SELECT 'SQL Max Memory already set to ' + convert(varchar(4), (1.00 - @os_percent_mem)) + ' of total available memory'

-- Verify
SELECT value 'Current SQL Max Memory' FROM sys.configurations WHERE name = 'max server memory (MB)'
