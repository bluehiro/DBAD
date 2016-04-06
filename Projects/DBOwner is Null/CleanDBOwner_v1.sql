 IF OBJECT_ID('tempdb..#db_list') IS NOT NULL
        DROP TABLE #db_list 

create table #db_list
(
name sysname
,db_size nvarchar(13)
,owner sysname
,dbid smallint
,created nvarchar(11)
,status nvarchar(600)
,compatibility_level tinyint
)
go
insert into #db_list
exec sp_helpdb

select * 
from #db_list x
WHERE x.[owner] <> 'sa'


PRINT '--SQL Code Below'

DECLARE @id INT
DECLARE @name NVARCHAR(100)
DECLARE @getid CURSOR
DECLARE @dynsql VARCHAR(200)

SET @getid = CURSOR FOR
SELECT name--table.id,
FROM   #db_list WHERE [owner] <> 'SA'

OPEN @getid
FETCH NEXT
FROM @getid INTO @name
SET @dynsql = NULL
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @dynsql = 'USE ' + @name + ' EXEC sp_changedbowner ''sa'''
	PRINT @dynsql
    FETCH NEXT
    FROM @getid INTO @name
END

CLOSE @getid
DEALLOCATE @getid

DROP TABLE #db_list