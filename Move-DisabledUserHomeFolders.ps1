$Archive = "\\192.168.88.205\Archived User Home Directories"
$Users = Get-ADUser -Filter {Enabled -eq "False" -SearchBase "OU=Users,DC=domain,DC=local"
Foreach ($User in $Users) 
{
Move-Item -Path $User.HomeDirectory -Destination $Archive -WhatIf
}