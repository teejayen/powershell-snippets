$Customers = Import-CSV C:\temp\rdpcustomers.csv

foreach ($Customer in $Customers){
    Write-Host "Testing $($Customer.Name) - $($Customer.PublicIP) now..."
	$RDP = Test-NetConnection -ComputerName $($Customer.PublicIP) -Port 3389 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue 
	$Result = $null
	if($RDP.TcpTestSucceeded){
	Write-Host "Port 3389 is listening" -ForegroundColor Red
	$Result = "Listening"
	}

	else{
    Write-Host "Port 3389 is not listening"
	}
		
	if($Result -like "Listening"){
		$ResultsExport = $null
		$ResultsExport = [ordered]@{
			Customer = $Customer.Name
			PublicIP = $Customer.PublicIP
			Result = $Result
		}
		
		$ResultObject = New-Object PSObject -Property $ResultsExport
		$ResultObject | Export-Csv C:\temp\rdpcustomersresult.csv -NoTypeInformation -Append
	}

}