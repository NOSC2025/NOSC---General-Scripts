Get-Mailbox | Get-MailboxPermission | Where-Object { $_.User -like "username@clientcompany.com.au" }
