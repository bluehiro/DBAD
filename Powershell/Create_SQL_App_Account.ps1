New-ADUser -Path "OU=SQL Service Accounts,OU=Service Accounts,OU=Special Accounts,DC=ohsum01,DC=ohsu,DC=edu" -Name "svcnicvuedb-app" -DisplayName "svcnicvuedb-app" -Description "SERVICE: account for sql on NICVUEDB" `
        -AccountPassword "~y$BGqgd" -UserPrincipalName "svcnicvuedb-app@ohsum01.ohsu.edu" `
        -SamAccountName "svcnicvuedb-app" -CannotChangePassword $true -PasswordNeverExpires $true `
        -Enabled $true -Server ohsum01.ohsu.edu