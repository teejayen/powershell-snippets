$Username = "tneilen@answersit.com.au"
$Password = ""
$Credentials = New-Object System.Management.Automation.PsCredential($Username,(ConvertTo-SecureString $Password -AsPlainText -Force))
$SlackToken = "xoxp-"
$CalendarItem = Invoke-RestMethod -Uri "https://outlook.office365.com/api/v1.0/users/tneilen@answersit.com.au/calendarview?startDateTime=$((Get-Date).AddHours(-10))&endDateTime=$((Get-Date).AddHours(-10))" -Credential $Credentials | foreach-object{ $_.Value } | Select-Object -ExpandProperty Subject

$payload = @"
{
    "profile":[

        {
            "status_text" = $CalendarItem,
            "status_emoji" = ":spiral_calendar_pad:"
        }
    ]
}
"@

Invoke-WebRequest -Body $payload -Method Post -Uri "https://slack.com/api/users.profile.set" -Headers @{Authorization = "Bearer $SlackToken"} -ContentType 'application/json;charset=utf-8' | Select-Object -ExpandProperty RawContent