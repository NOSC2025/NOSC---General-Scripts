Get-Mailbox -ResultSize Unlimited -Filter "RecipientTypeDetails -eq 'UserMailbox'" |
Select PrimarySmtpAddress |
ForEach {
    Set-Mailbox -Identity $_.PrimarySmtpAddress -AuditAdmin Copy, Create, FolderBind, HardDelete, MailItemsAccessed, Move, MoveToDeletedItems, SendAs, SendOnBehalf, SoftDelete, Update
}

