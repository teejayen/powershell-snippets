$Users = Get-ADUser -Filter * -SearchBase "OU=Active,OU=Users,DC=internal,DC=answersit,DC=com,DC=au"
$Domain = "answersit.com.au"

ForEach ($User in $Users) {
    try {
        Set-ADUser -Identity $user.samaccountname`
            -add @{ 'proxyAddresses' = "smtp:$($user.samaccountname)@$Domain" }`
            -Verbose -ErrorAction Stop
    }
    catch {
        Write-Warning "Error setting value for $($user.SamAccountName)"
    }
}