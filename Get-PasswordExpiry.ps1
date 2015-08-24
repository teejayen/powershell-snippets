Import-Module ActiveDirectory
Get-ADUser -filter {(Enabled -eq $True) -and (PasswordNeverExpires -eq $False)} -Properties DisplayName, msDS-UserPasswordExpiryTimeComputed | Where-Object {$_.DisplayName -ne $null} | Select DisplayName,@{Name="ExpiryDate";Expression={([datetime]::fromfiletime($_."msDS-UserPasswordExpiryTimeComputed"))}} | Convertto-CSV -NoTypeInformation
