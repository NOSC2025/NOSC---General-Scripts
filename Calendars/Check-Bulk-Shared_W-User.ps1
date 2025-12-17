# Connect to Exchange Online
Connect-ExchangeOnline

$targetUser = Read-Host -Prompt "Enter the target user's email address"

Get-Mailbox | ForEach-Object {
    $mailbox = $_
    Get-MailboxFolderPermission "$($mailbox.PrimarySmtpAddress):\Calendar" -User $targetUser -ErrorAction SilentlyContinue | ForEach-Object {
        [PSCustomObject]@{
            CalendarOwner = $mailbox.DisplayName
            Identity = $_.Identity
            User = $_.User
            AccessRights = $_.AccessRights
        }
    }
} | Select-Object CalendarOwner, Identity, User, AccessRights

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false
