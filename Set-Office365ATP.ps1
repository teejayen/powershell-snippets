$Credentials = Get-Credential
$SafeAttachmentsPolicyName = "aIT - Safe Attachments Policy"
$SafeAttachmentsPolicyDescription = "aIT Safe Attachments Policy V1.0 - Block Delivery"
$SafeAttachmentsRuleName = "All Recipients"
$RedirectTo = "atpmailbox@answersit.com.u"
$SafeLinksPolicyName = "aIT - Safe Links Policy"
$SafeLinksPolicyDescription = "aIT Safe Links Policy V1.0"

Connect-MsolService -Credential $credentials

$Customers = Get-MsolPartnerContract -All 
$msolUserResults = @()
foreach ($customer in $customers) {
  
$InitialDomain = Get-MsolDomain -TenantId $cid | Where-Object {$_.IsInitial -eq $true}

$DelegatedOrgURL = "https://outlook.office365.com/powershell-liveid?DelegatedOrg=" + $InitialDomain.Name
$EXODS = New-PSSession -ConnectionUri $DelegatedOrgURL -Credential $credentials -Authentication Basic -ConfigurationName Microsoft.Exchange -AllowRedirection
Import-PSSession $EXODS -AllowClobber -CommandName Get-AcceptedDomain, New-SafeAttachmentPolicy, New-SafeAttachmentRule, New-SafeLinksPolicy, New-SafeLinksRule, Get-AtpPolicyForO365, Set-AtpPolicyForO365
Set-AtpPolicyForO365 -Identity Default -EnableATPForSPOTeamsODB $true -EnableSafeLinksForClients $true -EnableSafeLinksForWebAccessCompanion $true -TrackClicks $true 
New-SafeLinksPolicy -Name $safeLinksPolicyName -AdminDisplayName $safeLinksPolicyDescription -Enabled $true -DoNotTrackUserClicks $false -ScanUrls $true -EnableForInternalSenders $true
$domains = Get-AcceptedDomain
$domains = $domains.name -join ","
New-SafeAttachmentPolicy -Name $safeAttachmentsPolicyName -Redirect $true -Enable $true -AdminDisplayName $safeAttachmentsPolicyDescription -Action Block ` -RedirectAddress $redirectTo -ActionOnError $false 
New-SafeAttachmentRule -SafeAttachmentPolicy $safeAttachmentsPolicyName -RecipientDomainIs $domains -Name $safeAttachmentsRuleName
Remove-PSSession $EXODS