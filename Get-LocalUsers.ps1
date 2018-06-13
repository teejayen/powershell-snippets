Import-Module ActiveDirectory
$Domain = Get-ADComputer -filter * | Select-Object -ExpandProperty Name

ForEach ($Computer in $Domain) {
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet) {
        Get-WmiObject -Class Win32_UserAccount -ComputerName $Computer -Filter "LocalAccount='True'" | Select-Object PSComputerName,Name,Disabled,SID | Export-CSV -Append "c:\temp\localusers.csv"
    }
}