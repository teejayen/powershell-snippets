Get-ChildItem . -Filter '*' -Recurse | Where-Object { $_.PSIsContainer } | Select-Object FullName | Out-Csv DirectoryListing.csv
