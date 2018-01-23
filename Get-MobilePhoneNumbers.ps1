Import-Module ActiveDirectory
Get-ADUser -Filter 'Mobile -like "*"' -Properties Name,MobilePhone | Select-Object Name,MobilePhone | Export-Csv file.csv