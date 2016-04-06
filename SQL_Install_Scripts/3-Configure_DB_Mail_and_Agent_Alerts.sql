/***************************  Set up Database Mail  *******************************
OHSU Standard SQL Server Script
Notes: Configures surface area configuration, sets up Database Mail, and sends a 
new server notification email to dbsq@ohsu.edu

ChangeLog: 
2015-08-27 VMJ - Added comments and this tombstone

*/

-- Surface Area Configuration Setup
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

GO
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Agent XPs', 1;
GO
RECONFIGURE
GO

-- Set up a primary DB Mail account for this SQL instance
DECLARE @email_addr  varchar(30), @ProfileName sysname
SET @email_addr = 'svcdbcooper@ohsu.edu'
SET @ProfileName = @@SERVERNAME + ' ' + @email_addr

DECLARE 
    @AccountDescription nvarchar(256) = @@SERVERNAME
  , @AccountName sysname = @ProfileName
  , @DisplayName nvarchar(128) = @ProfileName
  , @EmailAddress nvarchar(128) = @email_addr
  , @MailServer sysname = 'smtpout.ohsu.edu'
  , @ReplyToAddress nvarchar(128) = @email_addr
  , @ProfileDescription nvarchar(256) = @ProfileName
 
  
BEGIN TRY

		EXECUTE msdb.dbo.sysmail_add_account_sp 
			@account_name = @AccountName,
			@description = @AccountName,
			@email_address = @email_addr,
			@replyto_address = @email_addr,
			@display_name = @AccountName,
			@mailserver_name = @MailServer ;


		-- Create a Database Mail profile
		EXECUTE msdb.dbo.sysmail_add_profile_sp  
			@profile_name = @ProfileName;

		-- Add the primary account to the profile
		EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
			@profile_name = @ProfileName,
			@account_name = @AccountName,
			@sequence_number = 1 ;

		-- Grant access to the profile to all users
		EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
			@profile_name = @ProfileName,
			@principal_name = 'public',
			@is_default = 1;

		---- Send a test email
		--DECLARE @send_to NVARCHAR(20)
		--SET @send_to = 'willidar@ohsu.edu'

		--EXECUTE msdb.dbo.sp_send_dbmail
		--	@profile_name = @ProfileName,
		--	@recipients = @send_to,
		--	@subject = 'Space check',
		--	@query = 'set nocount on;exec master.dbo.xp_fixeddrives';

END TRY

BEGIN CATCH
    IF (@@TRANCOUNT > 0)
        ROLLBACK TRANSACTION
 
    DECLARE @ErrorMessage nvarchar(2048) = ERROR_MESSAGE()
      , @ErrorSeverity int = ERROR_SEVERITY()
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
    
END CATCH



--the following 
--right click on Sql Server Agent and select properties
--click on Alert System tab
--check the Enable mail profile 

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1

EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent', 
N'UseDatabaseMail', N'REG_DWORD', 1

EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent', 
N'DatabaseMailProfile', N'REG_SZ', @ProfileName


--Send Test Email
Declare @sql nvarchar(100)
Declare @email_body nvarchar(MAX)
Set @sql = 'New SQL Server instance created: ' + @@Servername +' - Database mail test.'
Set @email_body='The air is quiet and nary a creature stirs... yet something disturbs the stillness.  Out of the shadows emerges a frightening figure...it''s ' + @@SERVERNAME +'! Run away!!!!' + CHAR(10) +
''+ CHAR(10) +
'                                                       /(  /('+ CHAR(10) +
'                                                      /  \/  \'+ CHAR(10) +
'                                               /(/(  /    \___\'+ CHAR(10) +
'                                              /  \.-~         ~-._'+ CHAR(10) +
'                                        /^\.-~   __            /^~~~^\'+ CHAR(10) +
'        ___                        /\.-~       /~  ~\         (o\   /o)'+ CHAR(10) +
'       (_  `.                 /\.-~            |    |         |.     .|'+ CHAR(10) +
'         `.  :           /\.-~  __             |    |         |\`. .`/|'+ CHAR(10) +
'        .`  .`         .~    .-~  ~-.          |    |         |\\___//|'+ CHAR(10) +
'      .` . `          /     :        \         (    |    _.-~`\ \) )/ /'+ CHAR(10) +
'   .`  .            .`      \         \         \   \_.-~      \_( (_/'+ CHAR(10) +
' .`  .            .`        `\         \        .\   \___        )/\)'+ CHAR(10) +
'(   (           .`            \         \   _.-~  \_  _ _\'+ CHAR(10) +
'`   `.        .`               \         \-~        `\\\\\\'+ CHAR(10) +
' `    `.    .`                  \        /           )/)/)/'+ CHAR(10) +
'  `     `..`                ___.~)      /'+ CHAR(10) +
'   `                      _-    /      /'+ CHAR(10) +
'    `.                  _-/-._.-\     /'+ CHAR(10) +
'      `-._            .`  \    ( \   /'+ CHAR(10) +
'          `---..__---~     \   | /   \'+ CHAR(10) +
'                            \__||     ~-.___'+ CHAR(10) +
'                             \/ /__________/>'

EXEC msdb.dbo.sp_send_dbmail
@recipients=N'dbsq@ohsu.edu',
@subject=@sql,
@body=@email_body;

PRINT 'New Server notification email sent'
