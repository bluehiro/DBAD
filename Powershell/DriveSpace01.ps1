# Created: 2015-10-12
# Author: Vince James
# Description: Exports drive space (including drives mounted as directories) to a file share
#
# ChangeLog:

$directory = "\\dbad04\SQLBackups\CDW_DriveMonitor\"
$extension = ".txt"
$datestamp = [DateTime]::Now.ToString("yyyyMMdd")
$servername = Get-WmiObject Win32_computersystem | Select-Object Name
$space = Get-WmiObject Win32_Volume | select-object Name, Freespace

$output = $directory + $servername.Name + "_drivespace_" + $datestamp + $extension

$space | Select-Object @{Name='ServerName';Expression={$servername.Name}},Name,Freespace | 
Out-File $output