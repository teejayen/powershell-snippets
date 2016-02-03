 $convert = {
    Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | ForEach-Object {
        $md = Export-MailboxDiagnosticLogs -Identity $_.Identity -ExtendedProperties
        $properties = @{Identity=$md.Identity}
        (Select-Xml -Content  $md.MailboxLog -Xpath "//Property").Node | ForEach-Object { $properties[$_.Name] = $_.Value }
        New-Object -Type PSObject -Property $properties | Select Identity,ELCLastSuccessTimestamp,ElcLastRunArchivedFromRootItemCount
    }
}
 
&$convert | Export-Csv "archive-status.csv" -Verbose  
