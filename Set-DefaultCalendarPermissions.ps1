foreach($user in Get-Mailbox -RecipientTypeDetails UserMailbox) {
$Calendar = $user.alias+":\Calendar"
Set-MailboxFolderPermission -Identity $Calendar -User Default -AccessRights Reviewer
}