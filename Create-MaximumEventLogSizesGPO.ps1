$Domain = Get-ADDomain | Select-Object -ExpandProperty DistinguishedName

New-GPO -Name "Comp-Cfg - Maximum Event Log Sizes"
Set-GPRegistryValue -Name "Comp-Cfg - Maximum Event Log Sizes" -Key "HKLM\Software\Policies\Microsoft\Windows\EventLog\Security" -ValueName 'MaxSize' -Value 2097152 -Type Dword
Set-GPRegistryValue -Name "Comp-Cfg - Maximum Event Log Sizes" -Key "HKLM\Software\Policies\Microsoft\Windows\EventLog\Application" -ValueName 'MaxSize' -Value 65536 -Type Dword
Set-GPRegistryValue -Name "Comp-Cfg - Maximum Event Log Sizes" -Key "HKLM\Software\Policies\Microsoft\Windows\EventLog\System" -ValueName 'MaxSize' -Value 65536 -Type Dword

Get-GPO -Name "Comp-Cfg - Maximum Event Log Sizes" | New-GPLink -Target $Domain -LinkEnabled Yes