USE DBA_Rep

DECLARE @retrievedate DATETIME = (SELECT MAX(retrievedate) FROM [DBA_Rep].[dbo].[DBA_PULL_drivespace_history])
SELECT [ID]
      ,[servername]
      ,[drive_letter]
      ,[mb_free]
      ,[retrievedate]
  FROM [DBA_Rep].[dbo].[DBA_PULL_drivespace_history]
  WHERE retrievedate = @retrievedate

  DELETE FROM [DBA_Rep].[dbo].[DBA_PULL_drivespace_history]
  WHERE retrievedate = @retrievedate