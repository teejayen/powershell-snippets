Import-Module ActiveDirectory
Get-ADObject -Properties mail, proxyAddresses -Filter {mail -eq "<email>" -or proxyAddresses -eq "smtp:<email>"}
