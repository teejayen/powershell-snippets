Get-ChildItem . -Filter '*' -Recurse | Where-Object { $_.PSIsContainer } | Select FullName | Out-Csv DirectoryListing.csv
