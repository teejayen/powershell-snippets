Import-Module ActiveDirectory
$Time = (Get-Date).Adddays(-(30))
Search-ADAccount -AccountInactive -UsersOnly -Date $Time | where {$_.LastLogonDate -ne $null} | Disable-ADAccount