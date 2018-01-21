Import-Module ActiveDirectory
$User = Read-Host -Prompt "Enter terminated username"
$Password = Invoke-WebRequest -uri http://www.dinopass.com/password/strong
$PrimaryGroupToken = (Get-ADGroup "Domain Users" -Properties PrimaryGroupToken).PrimaryGroupToken

Set-ADAccountPassword $User -reset -newpassword (ConvertTo-SecureString -AsPlainText $Password -Force) 
Set-AdAccountExpiration $User -timespance 180.0:0
Get-ADUser $User -Properties PrimaryGroup,MemberOf | ForEach-Object {
If ($_.PrimaryGroup -notmatch "Domain Users"){
    Set-ADUser -Identity $_ -Replace @{PrimaryGroupID = $PrimaryGroupToken} -Verbose
    }
If ($_.memberof) {
            $Group = Get-ADPrincipalGroupMembership -Identity $_ | Where-Object {$_.Name -ne 'Domain Users'}
                     Remove-ADPrincipalGroupMembership -Identity $_ -MemberOf $Group -Confirm:$false -Verbose
                  }
}