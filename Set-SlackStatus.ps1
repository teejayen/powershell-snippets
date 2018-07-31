#Office 365 login details
$Username = ""
$Password = ""
$Credentials = New-Object System.Management.Automation.PsCredential($Username,(ConvertTo-SecureString $Password -AsPlainText -Force))

$SlackToken = ""

$CalendarItem = Invoke-RestMethod -Uri "https://outlook.office365.com/api/v1.0/users/$UserName/calendarview?startDateTime=$((Get-Date).AddHours(-10))&endDateTime=$((Get-Date).AddHours(-10))" -Credential $Credentials | foreach-object{ $_.Value } | Select-Object -ExpandProperty Subject

$Payload = @{"status_text" = $CalendarItem;"status_emoji" = ":spiral_calendar_pad:"}
$JSON = ConvertTo-Json $Payload

Invoke-WebRequest -Method Post -Uri https://slack.com/api/users.profile.set?token=$SlackToken"&"profile=$JSON