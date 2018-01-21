$User = Read-Host -Prompt "Enter terminated username"
$Manager = Read-Host -Prompt "Enter manager / forwarding address"
 
$Mailbox = Get-Mailbox $User
$Groups = Get-DistributionGroup | where { (Get-DistributionGroupMember $_.Name | foreach {$_.Id}) -contains $Mailbox.Id }
$Groups | ForEach-Object { Remove-DistributionGroupMember $_.DisplayName -Member $Mailbox.Id -BypassSecurityGroupManagerCheck -Confirm:$false -Verbose }
  
Set-Mailbox -Identity $User -HiddenFromAddressListsEnabled $True -Verbose
Set-Mailbox -Identity $User -Type Shared
If($Manager) { Set-Mailbox -Identity $User -DeliverToMailboxAndForward $True -ForwardingAddress $Manager -Verbose }
ForEach($license in Get-MsolAccountSku) {
    try {
        Get-MsolUser -UserPrincipalName $User | Set-MsolUserLicense -RemoveLicenses $license.AccountSkuId -ErrorAction Stop
        Write-Output ("Removed {0} from {1}" -f $User, $license.AccountSkuId)
    }
    catch { }
}