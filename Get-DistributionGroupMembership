$User = read-host -Prompt "Enter username"
$UserDN = (get-mailbox $user).distinguishedname
"User " + $User + " is a member of the following groups:"
foreach ($Group in Get-DistributionGroup -ResultSize unlimited){
if ((Get-DistributionGroupMember $Group.identity | select -expand distinguishedname) -contains $UserDN){$Group.name}
}
