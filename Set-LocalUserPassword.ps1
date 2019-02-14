#Prompt for user details
$User = Read-Host -Prompt "Enter local username"
$Password = Read-Host -AsSecureString -Prompt "Enter new password"

#Set new password.
$User | Set-LocalUser -Password $Password

#Disable PIN sign in option.
Remove-Item -LiteralPath "C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\NGC\" -Force -Recurse