Get-EventLog System | Where-Object {$_.EventID -eq "1074" -or $_.EventID -eq "6008" -or $_.EventID -eq "1076"} | ft MachineName, TimeWritten, UserName, EventID, Message -AutoSize -Wrap