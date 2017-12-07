Get-MsolUser | Where-Object { -Not $_.PasswordNeverExpires } | ForEach-Object {
	Write-Output "Disabling password expiration for $($_.UserPrincipalName)"
	Set-MsolUser -UserPrincipalName $_.UserPrincipalName -PasswordNeverExpires $True -Verbose
}
