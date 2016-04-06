USE DBA_Rep

DECLARE @retrievedate DATETIME = (SELECT MAX(retrievedate) FROM [DBA_Rep].[dbo].DBA_PULL_freespace_history)

SELECT * FROM DBA_PULL_freespace_history dpfh
WHERE dpfh.retrievedate = @retrievedate

DELETE FROM DBA_PULL_freespace_history WHERE retrievedate = @retrievedate