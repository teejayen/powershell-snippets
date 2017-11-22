Import-Module ActiveDirectory
(get-aduser -SearchBase "OU=Users,OU=Company,DC=domain,DC=local" -filter *|where {$_.enabled -eq "True"}).count
