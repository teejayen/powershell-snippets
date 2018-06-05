#TPP Wholesale API login details
$AccountNo =
$UserId = 
$Password =

#Remove files from previous runs
Remove-Item -Path C:\temp\domains.csv
Remove-Item -Path C:\temp\domains.json

#Create CSV file with headers
New-Item -Path C:\temp\domains.csv -value "Domain,Owner,Expiry`n"

#Generate Session ID
$Session = (Invoke-WebRequest "https://theconsole.tppwholesale.com.au/api/auth.pl?AccountNo=$AccountNo&UserId=$UserId&Password=$Password").Content
$SessionID = $Session.SubString(4)
Write-Host "Your SessionID is $SessionID"

#Request all domains, owner, and expiry date
(Invoke-WebRequest "https://theconsole.tppwholesale.com.au/api/query.pl?SessionID=$SessionID&Type=Domains&Object=Domain&Action=List").Content | Out-File C:\temp\domains.csv -Append -Force -Encoding ASCII

#Clean up CSV file, then output into JSON
(Get-Content C:\temp\domains.csv -Raw) -Replace '<BR>,', "`r`n" | Set-Content C:\temp\domains.csv
Get-Content C:\temp\domains.csv | ConvertFrom-Csv -Delimiter ',' | ConvertTo-Json | Out-File c:\temp\domains.json