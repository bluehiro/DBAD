/* 
OHSU Standard SQL Server Notifications - PRODUCTION
Notes: This script send email-only alerts and should not page anyone

ChangeLog: 
2015-08-27 VMJ - Reset versioning for clarity, added comments and this tombstone

*/
 
PRINT 'DEVELOPMENT OHSU Standard SQL Server Notifications'

PRINT '01 Remove Default SQL Server Alerts'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Full msdb log'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Full msdb log' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Full msdb log'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Full msdb log' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Full tempdb'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Full tempdb'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev 17 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev 17 Error' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 19 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 19 Errors' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 20 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 20 Errors'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 21 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 21 Errors'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 22 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 22 Errors'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 23 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 23 Errors'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 24 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 24 Errors'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Demo: Sev. 25 Errors'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Demo: Sev. 25 Errors'

PRINT '02 Remove OHSU-modified Alerts'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Full msdb log'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Full msdb log' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Full tempdb'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Full tempdb'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 17 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 17 Error' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 19 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 19 Error' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 20 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 20 Error'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 21 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 21 Error'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 22 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 22 Error'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 23 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 23 Error'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 24 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 24 Error'

IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 25 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 25 Error'

PRINT '03 Add in OHSU-modified Alerts'
---Wait 15 minutes
EXECUTE msdb.dbo.sp_add_alert @name = N'Full msdb log', @message_id = 9002, @severity = 0, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @database_name = N'msdb', @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Full tempdb', @message_id = 9002, @severity = 0, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @database_name = N'tempdb', @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 17 Error', @message_id = 0, @severity = 17, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 7, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 19 Error', @message_id = 0, @severity = 19, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 20 Error', @message_id = 0, @severity = 20, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 21 Error', @message_id = 0, @severity = 21, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 22 Error', @message_id = 0, @severity = 22, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 23 Error', @message_id = 0, @severity = 23, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 24 Error', @message_id = 0, @severity = 24, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'
EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 25 Error', @message_id = 0, @severity = 25, @enabled = 1, @delay_between_responses = 900, @include_event_description_in = 5, @category_name = N'[Uncategorized]'

PRINT '04 Add OHSU Transaction Log Alert'

IF CONVERT(nvarchar(32), SERVERPROPERTY('ProductVersion')) > '9'
BEGIN
--This is a SQL 2005 server
    IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Full Transaction Log'))
 ---- Delete the alert with the same name.
 	EXECUTE msdb.dbo.sp_delete_alert @name = N'Full Transaction Log' 
BEGIN 
	EXECUTE msdb.dbo.sp_add_alert @name = N'Full Transaction Log', @message_id = 9002, @severity = 0, 
        @enabled = 1, @delay_between_responses = 600, @include_event_description_in = 3, 
        @event_description_keyword = N'transaction log for database ', 
        @category_name = N'[Uncategorized]'
END
END
ELSE
BEGIN
--This is a SQL 2000 server
    IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Full Transaction Log'))
 ---- Delete the alert with the same name.
 	EXECUTE msdb.dbo.sp_delete_alert @name = N'Full Transaction Log' 
BEGIN 
	EXECUTE msdb.dbo.sp_add_alert @name = N'Full Transaction Log', @message_id = 0, @severity = 17, 
        @enabled = 1, @delay_between_responses = 600, @include_event_description_in = 3, 
        @event_description_keyword = N'Back up the transaction log for the database to free up some log space.', 
        @category_name = N'[Uncategorized]'
END
END



PRINT '05 Add OHSU DBAs as Operators'
--Note: This is where you add/remove DBA's whenever someone joins/leaves the team
--If removing, be sure to move their name to the remove operator script at the end

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'DBA On Call'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'DBA On Call' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'DBA On Call', @enabled = 1, @email_address = N'itgdba@ohsu.edu', @pager_address = N'itgdba@ohsu.edu', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 0, @weekday_pager_end_time = 235959, @saturday_pager_start_time = 0, @saturday_pager_end_time = 235959, @sunday_pager_start_time = 0, @sunday_pager_end_time = 235959, @pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'DBA On Call', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'DBA On Call', @notification_method = 1

END


IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Frank Evans'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Frank Evans' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Frank Evans', @enabled = 1, @email_address = N'evansf@ohsu.edu', @pager_address = N'12039@pager.ohsu.edu', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 0, @weekday_pager_end_time = 235959, @saturday_pager_start_time = 0, @saturday_pager_end_time = 235959, @sunday_pager_start_time = 0, @sunday_pager_end_time = 235959, @pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Frank Evans', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Frank Evans', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Frank Evans', @notification_method = 3

END


IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Lavar Moore'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Lavar Moore' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Lavar Moore', @enabled = 1,
 @email_address = N'moorew@ohsu.edu', @pager_address = N'10788@pager.ohsu.edu',
 @category_name = N'[Uncategorized]', @weekday_pager_start_time = 0, @weekday_pager_end_time = 235959, @saturday_pager_start_time = 0,
 @saturday_pager_end_time = 235959, @sunday_pager_start_time = 0, @sunday_pager_end_time = 235959, @pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Lavar Moore', @notification_method = 3

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Lavar Moore', @notification_method = 3

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Lavar Moore', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Lavar Moore', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Lavar Moore', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Lavar Moore', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Lavar Moore', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Lavar Moore', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Lavar Moore', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Lavar Moore', @notification_method = 3

END



IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Nathanael Tuggy'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Nathanael Tuggy' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Nathanael Tuggy', @enabled = 1, @email_address = N'tuggyn@ohsu.edu',
 @pager_address = N'10552@pager.ohsu.edu', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 0,
 @weekday_pager_end_time = 235959, @saturday_pager_start_time = 0, @saturday_pager_end_time = 235959, @sunday_pager_start_time = 0,
 @sunday_pager_end_time = 235959, @pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Nathanael Tuggy', @notification_method = 3

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Nathanael Tuggy', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Nathanael Tuggy', @notification_method = 3

END


IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Sean Ressler'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Sean Ressler' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Sean Ressler', @enabled = 1, @email_address = N'resslers@ohsu.edu',
 @pager_address = N'15106@pager.ohsu.edu', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 0,
 @weekday_pager_end_time = 235959, @saturday_pager_start_time = 0, @saturday_pager_end_time = 235959, @sunday_pager_start_time = 0, 
@sunday_pager_end_time = 235959, @pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Sean Ressler', @notification_method = 3

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Sean Ressler', @notification_method = 3

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Sean Ressler', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Sean Ressler', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Sean Ressler', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Sean Ressler', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Sean Ressler', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Sean Ressler', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Sean Ressler', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Sean Ressler', @notification_method = 3

END




IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Olga Tsytsyn'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Olga Tsytsyn' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Olga Tsytsyn',
@enabled = 1, 
@email_address = N'tsytsyn@ohsu.edu',
@pager_address = N'10706@pager.ohsu.edu',
@category_name = N'[Uncategorized]',
@weekday_pager_start_time = 0,
@weekday_pager_end_time = 235959, 
@saturday_pager_start_time = 0, 
@saturday_pager_end_time = 235959, 
@sunday_pager_start_time = 0, 
@sunday_pager_end_time = 235959,
@pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Olga Tsytsyn', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Olga Tsytsyn', @notification_method = 3

END



IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Vince James'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Vince James' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Vince James',
@enabled = 1, 
@email_address = N'jamesv@ohsu.edu',
@pager_address = N'16207@pager.ohsu.edu',
@category_name = N'[Uncategorized]',
@weekday_pager_start_time = 0,
@weekday_pager_end_time = 235959, 
@saturday_pager_start_time = 0, 
@saturday_pager_end_time = 235959, 
@sunday_pager_start_time = 0, 
@sunday_pager_end_time = 235959,
@pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Vince James', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Vince James', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Vince James', @notification_method = 3

END



IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Bruce McManus'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Bruce McManus' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Bruce McManus',
@enabled = 1, 
@email_address = N'mcmanus@ohsu.edu',
@pager_address = N'11911@pager.ohsu.edu',
@category_name = N'[Uncategorized]',
@weekday_pager_start_time = 0,
@weekday_pager_end_time = 235959, 
@saturday_pager_start_time = 0, 
@saturday_pager_end_time = 235959, 
@sunday_pager_start_time = 0, 
@sunday_pager_end_time = 235959,
@pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Bruce McManus', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Bruce McManus', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Bruce McManus', @notification_method = 3

END




/****** Object: Operator [Dan Otto] Script Date: 08/06/2010 14:12:52 ******/
IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Dan Otto'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Dan Otto' 
BEGIN 
EXEC msdb.dbo.sp_add_operator @name=N'Dan Otto',
@enabled=1,
@weekday_pager_start_time=0,
@weekday_pager_end_time=235959,
@saturday_pager_start_time=0,
@saturday_pager_end_time=235959,
@sunday_pager_start_time=0,
@sunday_pager_end_time=235959,
@pager_days=127,
@email_address=N'ottod@ohsu.edu',
@pager_address=N'11789@pager.ohsu.edu',
@category_name=N'[Uncategorized]'


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Dan Otto', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Dan Otto', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Dan Otto', @notification_method = 3

END



IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Dimitri Vizen'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Dimitri Vizen'
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Dimitri Vizen', @enabled = 1, @email_address = N'vizen@ohsu.edu',
 @pager_address = N'16579@pager.ohsu.edu', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 0,
 @weekday_pager_end_time = 235959, @saturday_pager_start_time = 0, @saturday_pager_end_time = 235959, @sunday_pager_start_time = 0,
 @sunday_pager_end_time = 235959, @pager_days = 127

EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full tempdb', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 17 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 19 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 20 Error', @operator_name = N'Dimitri Vizen', @notification_method = 1


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 21 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 22 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 23 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 24 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Sev 25 Error', @operator_name = N'Dimitri Vizen', @notification_method = 3


EXECUTE msdb.dbo.sp_add_notification @alert_name = N'Full Transaction Log', @operator_name = N'Dimitri Vizen', @notification_method = 3

END


/****** Object:  Operator [DBSQ]    Script Date: 10/24/2012 07:55:21 ******/
IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'DBSQ'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'DBSQ' 
BEGIN

EXEC msdb.dbo.sp_add_operator @name=N'DBSQ', 
		@enabled=1, 
		@email_address=N'DBSQ@ohsu.edu', 
		@category_name=N'[Uncategorized]'

end

--End operator adds

PRINT '06 Add Read Retry Error Alert'
USE [msdb]
GO

/****** Object:  Alert [Read Retry Error Alert]    Script Date: 08/06/2012 07:52:20 ******/
IF  EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Read Retry Error Alert')
EXEC msdb.dbo.sp_delete_alert @name=N'Read Retry Error Alert'
GO

USE [msdb]
GO

/****** Object:  Alert [Read Retry Error Alert]    Script Date: 08/06/2012 07:52:20 ******/
EXEC msdb.dbo.sp_add_alert @name=N'Read Retry Error Alert', 
		@message_id=825, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO


EXEC msdb.dbo.sp_add_notification @alert_name=N'Read Retry Error Alert', @operator_name=N'DBSQ', 
@notification_method = 1
GO

PRINT '07 Add improved Sev 17 & Sev 22 Error Alert'
/*
--Create OHSU_Trap_Sev17 and new Sev17 alert for a New SQL Installation -----
--20130301 Darcy Williams

--The following error triggered pages to the DBA on call because it is a Sev 17
   "Server local connection provider has stopped listening on [ \\.\pipe\SQLLocal\MSSQLSERVER ] 
   due to a failure. Error: 0xe8, state: 4. The server will automatically attempt to re-establish listening."

--This script creates a job called OHSU_Trap_Sev17 which looks at the error code for the
    sev17 to determine if the DBA on call needs to be paged.
    
--It is broken down into 3 sections
	1.  turn the tokens on.  the tokens are sent from the alert to the job then out with the page
	2.  deletes the job OHSU_Trap_Sev17 if it already exists
	3.  creates the job OHSU_Trap_Sev17
	4.  creates the Sev 17 alert
	5.  adds the operators to the Sev 17 alert
*/


--- turn tokens on
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @alert_replace_runtime_tokens=1
GO


--------------------------------------------------------------------------------
--delete the job if it already exists [OHSU_Trap_Sev17] 
USE [msdb]
GO

Declare @jobID as  [uniqueidentifier]

select @jobID = job_id FROM msdb.dbo.sysjobs
where name = 'OHSU_Trap_Sev17'

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'OHSU_Trap_Sev17')
EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
GO

----------------------------------------------------------------------------------
--- create the job [OHSU_Trap_Sev17] 
USE [msdb]
GO

/****** Object:  Job [OHSU_Trap_Sev17]    Script Date: 03/01/2013 10:30:29 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 03/01/2013 10:30:29 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'OHSU_Trap_Sev17', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=1, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBSQ', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Send Email Send Page]    Script Date: 03/01/2013 10:30:29 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Send Email Send Page', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE 
@serverName AS VARCHAR (128), 
@alertError AS VARCHAR (10), 
@alertSeverity AS VARCHAR (5),
@alertMsg AS VARCHAR (2100), 
@Desc AS VARCHAR (MAX), 
@Desc2 AS VARCHAR (MAX), 
@Subj AS VARCHAR (255),
@Subj2 AS VARCHAR (255),
@sendPage BIT


SET @serverName = ''$(ESCAPE_SQUOTE(A-SVR))''
SET @alertError = ''$(ESCAPE_SQUOTE(A-ERR))''
SET @alertSeverity = ''$(ESCAPE_SQUOTE(A-SEV))''
SET @alertMsg = ''$(ESCAPE_SQUOTE(A-MSG))''

SET @Subj = ''SQL Server Alert System: Sev '' + CAST (@alertSeverity AS CHAR (3)) + '' occurred on '' + @serverName;
SET @Subj2 = replace(@Subj,'''''''','''')

SET @Desc = ''DATE/TIME:   '' + CAST (GETDATE() AS VARCHAR (25)) + CHAR(13) + CHAR(10) + CHAR(10) + ''DESCRIPTION:  '' + @alertMsg;
SET @Desc2 = replace(@Desc,'''''''','''')


SET @sendPage = 1;

IF @alertSeverity = 17
    BEGIN
        IF (@alertError > 26000
            AND @alertError < 27000)
            SET @sendPage = 0;
    END

    BEGIN
        IF (@alertError = 35262)
            SET @sendPage = 0;
    END

IF @sendPage = 1
  BEGIN
	EXECUTE msdb.dbo.sp_send_dbmail
	@recipients = N''5032022743@page.metrocall.com; 5032025490@page.metrocall.com; 5036041445@page.metrocall.com; 5032025250@page.metrocall.com; 5032025255@page.metrocall.com; 5032025260@page.metrocall.com; 5032025275@page.metrocall.com; 5032022748@page.metrocall.com; 5032025274@page.metrocall.com '',
	@subject = @Subj2,
	@body = @Desc2
  END

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

--------------------------------------------------------------------------------------
-- create the new and improved Sev 17 Error Alert

USE [msdb]
GO

DECLARE @jobID AS [uniqueidentifier]

SELECT @jobID = job_id FROM msdb.dbo.sysjobs
WHERE name = 'OHSU_Trap_Sev17'


/****** Object:  Alert [Sev 17 Error]    Script Date: 03/01/2013 10:36:20 ******/
IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 17 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 17 Error' 

EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 17 Error',
 @message_id = 0, 
 @severity = 17, 
 @enabled = 1, 
 @delay_between_responses = 900, 
 @include_event_description_in = 7, 
 @category_name = N'[Uncategorized]',
 @job_id=@jobID

-- add all operators to the notification of the Sev 17 Error

DECLARE @Operator VARCHAR(100)

DECLARE @getOperator CURSOR

SET @getOperator = CURSOR FOR
SELECT name from sysoperators
WHERE email_address is not null
AND pager_address is not null

OPEN @getOperator

FETCH NEXT
FROM @getOperator INTO @Operator

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXECUTE msdb.dbo.sp_add_notification 
		@alert_name = N'Sev 17 Error', 
		@operator_name = @Operator, 
		@notification_method = 1

	    FETCH NEXT
        FROM @getOperator INTO @Operator
	END
	
CLOSE @getOperator
DEALLOCATE @getOperator

--------------------------------------------------------------------------------------

--sev 22 below

--- turn tokens on
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @alert_replace_runtime_tokens=1
GO


--------------------------------------------------------------------------------
--delete the job if it already exists [OHSU_Trap_Sev22] 
USE [msdb]
GO

Declare @jobID as  [uniqueidentifier]

select @jobID = job_id FROM msdb.dbo.sysjobs
where name = 'OHSU_Trap_Sev22'

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'OHSU_Trap_Sev22')
EXEC msdb.dbo.sp_delete_job @job_id=@jobID, @delete_unused_schedule=1
GO

----------------------------------------------------------------------------------
--- create the job [OHSU_Trap_Sev22] 
USE [msdb]
GO

/****** Object:  Job [OHSU_Trap_Sev22]    Script Date: 03/01/2013 10:30:29 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 03/01/2013 10:30:29 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'OHSU_Trap_Sev22', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=1, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBSQ', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Send Email Send Page]    Script Date: 03/01/2013 10:30:29 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Send Email Send Page', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE 
@serverName AS VARCHAR (128), 
@alertError AS VARCHAR (10), 
@alertSeverity AS VARCHAR (5),
@alertMsg AS VARCHAR (2100), 
@Desc AS VARCHAR (MAX), 
@Desc2 AS VARCHAR (MAX), 
@Subj AS VARCHAR (255),
@Subj2 AS VARCHAR (255),
@sendPage BIT


SET @serverName = ''$(ESCAPE_SQUOTE(A-SVR))''
SET @alertError = ''$(ESCAPE_SQUOTE(A-ERR))''
SET @alertSeverity = ''$(ESCAPE_SQUOTE(A-SEV))''
SET @alertMsg = ''$(ESCAPE_SQUOTE(A-MSG))''

SET @Subj = ''SQL Server Alert System: Sev '' + CAST (@alertSeverity AS CHAR (3)) + '' occurred on '' + @serverName;
SET @Subj2 = replace(@Subj,'''''''','''')

SET @Desc = ''DATE/TIME:   '' + CAST (GETDATE() AS VARCHAR (25)) + CHAR(13) + CHAR(10) + CHAR(10) + ''DESCRIPTION:  '' + @alertMsg;
SET @Desc2 = replace(@Desc,'''''''','''')


SET @sendPage = 1;

IF @alertSeverity = 22
    BEGIN
        IF (@alertError = 7105)
            SET @sendPage = 0;
    END

IF @sendPage = 1
  BEGIN
	EXECUTE msdb.dbo.sp_send_dbmail
	@recipients = N''5032022743@page.metrocall.com; 5032025490@page.metrocall.com; 5036041445@page.metrocall.com; 5032025250@page.metrocall.com; 5032025255@page.metrocall.com; 5032025260@page.metrocall.com; 5032025275@page.metrocall.com; 5032022748@page.metrocall.com; 5032025274@page.metrocall.com '',
	@subject = @Subj2,
	@body = @Desc2
  END

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


USE [msdb]
GO

DECLARE @jobID AS [uniqueidentifier]

SELECT @jobID = job_id FROM msdb.dbo.sysjobs
WHERE name = 'OHSU_Trap_Sev22'


/****** Object:  Alert [Sev 22 Error]    Script Date: 03/01/2013 10:36:20 ******/
IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Sev 22 Error'))
EXECUTE msdb.dbo.sp_delete_alert @name = N'Sev 22 Error' 

EXECUTE msdb.dbo.sp_add_alert @name = N'Sev 22 Error',
 @message_id = 0, 
 @severity = 22, 
 @enabled = 1, 
 @delay_between_responses = 900, 
 @include_event_description_in = 7, 
 @category_name = N'[Uncategorized]',
 @job_id=@jobID

-- add all operators to the notification of the Sev 17 Error

DECLARE @Operator VARCHAR(100)

DECLARE @getOperator CURSOR

SET @getOperator = CURSOR FOR
select name from sysoperators
where email_address is not null
and pager_address is not null

OPEN @getOperator

FETCH NEXT
FROM @getOperator INTO @Operator

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXECUTE msdb.dbo.sp_add_notification 
		@alert_name = N'Sev 22 Error', 
		@operator_name = @Operator, 
		@notification_method = 1

	    FETCH NEXT
        FROM @getOperator INTO @Operator
	END
	
CLOSE @getOperator
DEALLOCATE @getOperator

GO

--End add sev 17 & sev 22

PRINT '08 Remove any past employee operator records'
--- Remove Shane and Jon, Irina, Renee, Patrick, Edwin, Dave , Yan, Colin, Graeme, and others
IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'John Beebe'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'John Beebe' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Mike Street'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Mike Street' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Michael Street'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Michael Street' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Darcy Williams'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Darcy Williams' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Graeme Wilson'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Graeme Wilson' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Shane Goss'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Shane Goss' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Jon Waldow'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Jon Waldow' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Irina Federov'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Irina Federov' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Renee McKechnie'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Renee McKechnie' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Patrick Howard'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Patrick Howard' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Edwin Quick'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Edwin Quick' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Dave Gillespie'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Dave Gillespie' 

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Yantiff Shaykin'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Yantiff Shaykin'

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Gary Gray'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Gary Gray'

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Jerry Kohler'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Jerry Kohler'

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Colin Parker'))
EXECUTE msdb.dbo.sp_delete_operator @name = N'Colin Parker'