$previousmanager = Get-AzureADUser -Filter "UserPrincipalName eq 'previous@contoso.com'" | Select-Object ObjectID
$newmanager = Get-AzureADUser -Filter "UserPrincipalName eq 'new@contoso.com'" | Select-Object ObjectID

foreach ($user in Get-AzureAdUser) {Get-AzureADUserManager -ObjectID $user.ObjectID | where {$_.ObjectID -eq '$previousmanager'} | Set-AzureADUserManager -RefObjectId "$newmanager"}