$Sources = "\\t8nas2\Archive\","\\t8nas2\MYOB\","\\t8nas2\OldMYOBData\","\\t8nas2\Race Data\","\\t8nas2\Backups"
$Destinations = "\\tre-nas-ap03\Backup\","\\tre-nas-ap04\Backup\"
$Username = ""
$Password = ""
$Credentials = New-Object System.Management.Automation.PsCredential($Username,(ConvertTo-SecureString $Password -AsPlainText -Force))

foreach ($Destination in $Destinations){
    if ((Test-Path $Destination) -eq $False){
        Write-Output "$Destination is not accessible."
    }
    else {
        New-PSDrive -Name "S" -PSProvider "FileSystem" -Root $Source -Credentials $Credentials
        foreach ($Source in $Sources){
        New-PSDrive -Name "D" -PSProvider "FileSystem" -Root $Destination -Credentials $Credentials
        robocopy "$Source" "$Destination\$Source" /w:1 /r:1 /mir /np
        Write-Output "If Robocopy did not throw any errors, everything went fine!"
        }
    }
}