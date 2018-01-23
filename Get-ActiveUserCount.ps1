Import-Module ActiveDirectory
(Get-ADUser -SearchBase "OU=Users,OU=Company,DC=domain,DC=local" -filter *| Where-Object {$_.enabled -eq "True"}).count
