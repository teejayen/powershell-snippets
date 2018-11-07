$Customers = Import-CSV C:\temp\rdpcustomers-3.csv

foreach ($Customer in $Customers){
    Write-Host "Testing $($Customer.Name) - $($Customer.PublicIP) now..."
	$RDP = Test-NetConnection -ComputerName $($Customer.PublicIP) -Port 3389 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 

	if($RDP.TcpTestSucceeded){
    "Port 3389 is open"
	$Result = "Open"
	}

	else{
    "Port 3389 is filtered"
	}
		
	if($Result){
		$ResultsExport = $null
		$ResultsExport = [ordered]@{
			Customer = $Customer.Name
			PublicIP = $Customer.PublicIP
			Result = $Result
		}
		
		$ruleObject = New-Object PSObject -Property $ResultsExport
		$ruleObject | Export-Csv C:\temp\rdpcustomersresult.csv -NoTypeInformation -Append
	}
}