Import-Module ActiveDirectory
$User = Read-Host -Prompt "Enter terminated username"
$Ticket = Read-Host -Prompt "Enter ticket number for request"
$Password = Invoke-WebRequest -uri http://www.dinopass.com/password/strong
$TerminationDate = (Get-Date).AddMonths(6)
$PrimaryGroupToken = (Get-ADGroup "Domain Users" -Properties PrimaryGroupToken).PrimaryGroupToken
$UserDescription = "Terminated on $TerminationDate ($Ticket)"

Set-ADAccountPassword $User -reset -newpassword (ConvertTo-SecureString -AsPlainText $Password -Force) 
Set-AdAccountExpiration $User -datetime $TerminationDate
Get-ADUser $User -Properties PrimaryGroup,MemberOf | ForEach-Object {
If ($_.PrimaryGroup -notmatch "Domain Users"){
    Set-ADUser -Identity $_ -Replace @{PrimaryGroupID = $PrimaryGroupToken} -Verbose
    }
If ($_.memberof) {
            $Group = Get-ADPrincipalGroupMembership -Identity $_ | Where-Object {$_.Name -ne 'Domain Users'}
                     Remove-ADPrincipalGroupMembership -Identity $_ -MemberOf $Group -Confirm:$false -Verbose
                  }
}
Set-ADUser $User -Description $UserDescription
Write-Host "$User has been terminated!"
Write-Output "Password has been set to $Password"
Write-Output "User account will expire on (Get-Date).AddMonths(6)"
Write-Output "User has been removed from $_.memberof"