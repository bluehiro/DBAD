# Create SQL service accounts
# 
# Creates SQL services accounts according to OHSU ITG standards. Specify the hostname using the -hostname parameter. 
# The number and type of account are controlled by the -types parameter. By default, the script creates -agent and 
# -sql accounts. All possibilities are: sql,agent,ssrs,ssis,ssas
#
# Requires Active Directory powershell cmdlets to be installed (part of RSAT).
#
# Example #1 - Create deafult sql and agent accounts:
#     .\Create_SQL_Accounts.ps1 -hostname foo
#
# Example #2 - Create additional account types
#     .\Create_SQL_Accounts.ps1 -hostname bar -types sql,agent,ssrs,ssis
#
# ITG ECSV
# May 14, 2013
# Nathan Smith <sminatha@ohsu.edu> x4-6731



Param(
    # hostname
    [Parameter(Mandatory=$true)]
    [ValidatePattern("[a-zA-Z0-9]*")]
    [ValidateLength(0,15)]
    [String]
    $hostname,

    [ValidateSet("sql","agent","ssrs","ssis","ssas")]
    $types = @("sql","agent","ssis")
)

Function Get-TempPassword {
    $a = "Magnum","Orange","Kentucky","Blossom","Foxtrot","Pittsburgh","Rupert" | Get-Random
    $b = Get-Random -Minimum 10 -Maximum 99
    return $a + $b
}

Function New-SQLAccount ($hostname,$append) {
    $newOU = "OU=SQL Service Accounts,OU=Service Accounts,OU=Special Accounts,DC=ohsum01,DC=ohsu,DC=edu"
    $newUser = "svc$hostname-$append"
    $minidesc = switch($append) {
        "sql" {"sql"}
        default {"sql $append"}
    }
    $newDesc = "SERVICE: account for $minidesc on $hostname"
    $newPass = Get-TempPassword
    $securePass = $newPass | ConvertTo-SecureString -AsPlainText -Force
    $newGroup = switch($append) {
        "sql" {"svcsql"}
        "agent" {"svcsqlagent"}
        "ssis" {"svcsqlssis"}
        "ssrs" {"svcsqlssrs"}
        "ssas" {"svcsqlssas"}
    }
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
    Write-Debug "Adding user $newUser to group $newGroup"
    Add-ADGroupMember -Identity $newGroup -Members $newUser -Server ohsum01.ohsu.edu
    return 1
}

$DebugPreference = "Continue"
$hostLower = $hostname.ToLower()
Write-Debug "hostname = $hostLower"
Write-Debug "types = $types"

Import-Module ActiveDirectory

# Check for existence of computer account
Write-Debug "Checking for existence of $hostLower computer object"
$compObject = Get-ADComputer $hostLower -Server ohsu.edu

## Created to allow for creation of service accounts for ACC servers
#if ($compObject) {
    # Proceed with account creation

#        $out = New-SQLAccount $hostLower $appendix
#    }
#}

    foreach ($appendix in $types) {
        $out = New-SQLAccount $hostLower $appendix
    }

else {
    # Never mind
    Write-Error "Computer account $hostLower does not exist in ohsu.edu"
}