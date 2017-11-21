function Get-DistributionGroups
{   
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [Alias('Identity')]
        [string]
        $UserPrincipalName
    )

    $Recipient = Get-Recipient -Identity $UserPrincipalName

    $Groups = Get-Group -ResultSize Unlimited -RecipientTypeDetails 'MailUniversalDistributionGroup','MailUniversalSecurityGroup'

    foreach ($Group in $Groups)
    {
        if ($Group.Members -contains $Recipient.Identity) { $Group.Identity }
    }
}
