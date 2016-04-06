USE [ohsu_refresh]
GO

/****** Object:  StoredProcedure [dbo].[Master_Refresh]    Script Date: 2/24/2015 1:35:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* ============================================= 
Author: Vince James
Create date: 2015-02-24
Description: The sproc calls all the other sprocs and logs each step of the process
Changelog: 

    
EXEC Master_Refresh
============================================= */
CREATE PROCEDURE [dbo].[Master_Refresh]

AS
BEGIN

	--Declare Variables
	DECLARE @SourceDB VARCHAR(50)
	DECLARE @SourceServer VARCHAR(50)
	DECLARE @DestDB VARCHAR(50)
	DECLARE @DestServer VARCHAR(50)
	DECLARE @ID INT
	DECLARE @Message VARCHAR(50)
	DECLARE @Batch_UID INT

	--Set Variables
	SELECT TOP 1
		@ID = ID,
		@SourceServer = SourceServer,
		@SourceDB = SourceDB,
		@DestServer = DestServer,
		@DestDB = DestDB
	FROM [ohsu_refresh].[dbo].[Refresh]
	WHERE ScheduledDate <= GETDATE()
	ORDER BY ScheduledDate, ID

	--Only start process if there is a pending refresh in the Refresh table
	IF @ID IS NOT NULL
	BEGIN

		--SET @Message = 'ID = ' ++ CAST(@ID AS VARCHAR(50)) ++ ' SourceServer = ' ++ @SourceServer ++ ' SourceDB = ' ++ @SourceDB ++ ' DestServer = ' ++ @DestServer ++ ' DestDB = ' ++ @DestDB 

		--Log the batch details to the batch_log table
		INSERT INTO [dbo].[Refresh_Batch_Log] ([ID]
		, [Batch_Date]
		, [StoredProc]
		, [SourceServer]
		, [SourceDB]
		, [DestServer]
		, [DestDB])
			VALUES (@ID, GETDATE(), 'Master_Refresh', @SourceServer, @SourceDB, @DestServer, @DestDB)

		SET @Batch_UID = (SELECT TOP 1 rbl.Batch_UID FROM Refresh_Batch_Log rbl WHERE rbl.Batch_Date = (SELECT MAX(Batch_Date) FROM Refresh_Batch_Log))
		SET @Message = ('BatchID: ' + CONVERT(VARCHAR, @Batch_UID) + ' - Master_Refresh') 

		INSERT INTO Refresh_Log
			VALUES (@Batch_UID, @ID, GETDATE(), NULL, '01 Update dbo.refresh StartDate column to GETDATE()', @Message)

		UPDATE ohsu_refresh.dbo.Refresh
		SET StartDate = GETDATE()
		WHERE ID = @ID

		INSERT INTO Refresh_Log
			VALUES (@Batch_UID, @ID, GETDATE(), NULL, '02 Run dbo.RefreshDatabase stored proc', @Message)

		--Main Sproc, all other sprocs are downstream of this one
		EXEC RefreshDatabase	@SourceServer,
								@SourceDB,
								@DestServer,
								@DestDB,
								@ID,
								@Message,
								@Batch_UID

		INSERT INTO Refresh_Log
			VALUES (@Batch_UID, @ID, GETDATE(), NULL, '03 Set dbo.refresh Completed column to GETDATE()', @Message)

		UPDATE Refresh
		SET CompletedDate = GETDATE()
		WHERE ID = @ID

		INSERT INTO Refresh_Log
			VALUES (@Batch_UID, @ID, GETDATE(), NULL, '04 Set dbo.refresh ScheduledDate column to NULL', @Message)

		UPDATE Refresh
		SET ScheduledDate = NULL
		WHERE ID = @ID

		INSERT INTO Refresh_Log
			VALUES (@Batch_UID, @ID, GETDATE(), NULL, '05 Process Complete', @Message)

	END

END
GO


