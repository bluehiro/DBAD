New-NetFirewallRule -DisplayName “Open SQL Server Port 1433” -group “SQL Server” -Enabled True -Protocol tcp -RemotePort 1433 -Direction Inbound

