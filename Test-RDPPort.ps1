$Customers = Import-CSV C:\temp\rdpcustomers.csv
foreach ($Customer in $Customers) {
Write-Host "Testing $($Customer.Name) - $($Customer.PublicIP) now..."
$RDP = Test-NetConnection -ComputerName $($Customer.PublicIP) -Port 3389 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
if($RDP.TcpTestSucceeded)
{
    "Port 3389 is open"
}
else
{
    "Port 3389 is filtered"
}
}