Get-Ec2SecurityGroup $groupid -ProfileName $profile | ConvertTo-JSON -Depth 5 | Out-File %userprofile%\$groupid.json
