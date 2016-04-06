# Create SQL service accounts
# 
# Creates SQL services accounts according to OHSU ITG standards. Specify the hostname using the -hostname parameter. 
# The number and type of account are controlled by the -types parameter. By default, the script creates -agent and 
# -sql accounts. All possibilities are: sql,agent,ssrs,ssis,ssas
#
# Requires Active Directory powershell cmdlets to be installed (part of RSAT).
#
# Example #1 - Create sql app account:
#     .\Create_SQL_Accounts.ps1 -hostname foo
#
# ITG ECSV
# May 14, 2013
# Nathan Smith <sminatha@ohsu.edu> x4-6731
# 20141023 Vince James <jamesv@ohsu.edu> - Rewrote to allow for creation of sql app accounts with no naming restrictions



Param(
    # hostname
    [Parameter(Mandatory=$true)]
    [ValidatePattern("[a-zA-Z0-9]*")]
    [ValidateLength(0,15)]
    [String]
    $hostname,

    # accountname
    [Parameter(Mandatory=$true)]
    [ValidatePattern("[a-zA-Z0-9]*")]
    [ValidateLength(0,15)]
    [String]
    $accountname
)

Function Get-TempPassword {
    $a = "Trumpet","Saxony","Salamander","RoseCity","Stumptown","Alexandria","KeanuReeves" | Get-Random
    $b = Get-Random -Minimum 10 -Maximum 99
    return $a + $b
}

Function New-SQLAccount ($hostname,$accountname) {
    $newOU = "OU=SQL Service Accounts,OU=Service Accounts,OU=Special Accounts,DC=ohsum01,DC=ohsu,DC=edu"
    $newUser = "$accountname"
    $minidesc = "sql app"
    $newDesc = "SERVICE: account for $minidesc on $hostname"
    $newPass = Get-TempPassword
    $securePass = $newPass | ConvertTo-SecureString -AsPlainText -Force
    
    # Check for existence of the user
    $userCheck = Get-ADUser -Server ohsum01.ohsu.edu $newUser
    if ($userCheck) {
        Write-Warning "User $newUser already exists in ohsmu01.ohsu.edu"
        return 0
    }

    Write-Debug "Creating new user $newUser"
    New-ADUser -Path $newOU -Name $newUser -DisplayName $newUser -Description $newDesc `
        -AccountPassword $securePass -UserPrincipalName "$newUser@ohsum01.ohsu.edu" `
        -SamAccountName $newUser -CannotChangePassword $true -PasswordNeverExpires $true `
        -Enabled $true -Server ohsum01.ohsu.edu
    sleep -Seconds 3
    #Write-Debug "Adding user $newUser to group $newGroup"
    #Add-ADGroupMember -Identity $newGroup -Members $newUser -Server ohsum01.ohsu.edu
    return 1
}

$DebugPreference = "Continue"
$hostLower = $hostname.ToLower()
$accountLower = $accountname.ToLower()
Write-Debug "hostname = $hostLower"
Write-Debug "accountname = $accountLower"
Write-Debug "types = $types"

Import-Module ActiveDirectory

# Check for existence of computer account
Write-Debug "Checking for existence of $hostLower computer object"
$compObject = Get-ADComputer $hostLower -Server ohsu.edu

if ($compObject) {
    # Proceed with account creation

    $out = New-SQLAccount $hostLower $accountLower
}

else {
    # Never mind
    Write-Error "Computer account $hostLower does not exist in ohsu.edu"
}