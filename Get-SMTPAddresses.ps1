#Declare variables.

$EmailTempfile = "C:\O365Info\O365Emailproxy.csv"

$fileObjectEmail = New-Item $EmailTempFile -type file -force

$fileName = "C:\O365Info\O365EmailAddresses.csv"

$fileObject = New-Item $fileName -type file -force


$evt_string = "Displayname,EmailAddresses"

$evt_string | Out-file $fileObject -encoding ascii -Append

 

#Get the proxy addresses info

Get-Recipient -Resultsize unlimited -RecipientType Usermailbox | select DisplayName,EmailAddresses | Export-csv -notypeinformation $fileObjectEmail -append -encoding utf8

 

#Read outputs into a variable

$file = Get-Content $EmailTempfile

for($i=1;$i -lt $file.count;$i++){

$evt_string=""

 

#Split the proxy data into individual email addresses

$csvobj = ($file[$i] -split ",")

$EmailAddr = $csvobj[1]

$GetEmail = $EmailAddr -replace '"', '' -split(' ')

 

#Write out the display name and email addresses, filters for SMTP only, and removes onmicrosoft.com addresses

for($k=0;$k -lt $GetEmail.count;$k++){

If (($GetEmail[$k] -match "smtp:") -and ($GetEmail[$k] -notmatch "onmicrosoft.com")){

                $evt_string = $csvobj[0]+","+$GetEmail[$k].split(":")[1]

                $evt_string | Out-file $fileObject -encoding utf8 -Append

}

}

}
