# Connect to Exchange Online using administrator credentials - you will then need to log into Excahnge via Powershell with GA credentials (prompted)
Connect-ExchangeOnline

# Retrieve the mailbox object for the specified user
$targetUser = Read-Host -Prompt "Enter the target user's email address"
$mailbox = Get-Mailbox -Identity $targetUser

# Remove specific user configuration settings from the mailbox
{
    # Removes suite storage configurations related to OWA and mailbox settings
    Remove-MailboxUserConfiguration -Mailbox $mailbox.Identity -Identity Configuration\IPM.Configuration.Suite.Storage -Confirm:$false
    
    # Clears aggregated OWA user configuration settings
    Remove-MailboxUserConfiguration -Mailbox $mailbox.Identity -Identity Configuration\IPM.Configuration.Agregated.OWAUserConfiguration -Confirm:$false

    # Deletes the autocomplete cache from OWA to reset suggested addresses
    Remove-MailboxUserConfiguration -Mailbox $mailbox.Identity -Identity Configuration\IPM.Configuration.OWA.AutocompleteCache -Confirm:$false

    # Removes session-related configurations for OWA
    Remove-MailboxUserConfiguration -Mailbox $mailbox.Identity -Identity Configuration\IPM.Configuration.OWA.SessionInformation -Confirm:$false

    # Clears user options for OWA settings
    Remove-MailboxUserConfiguration -Mailbox $mailbox.Identity -Identity Configuration\IPM.Configuration.OWA.UserOptions -Confirm:$false

    # Deletes stored view state configurations for OWA
    Remove-MailboxUserConfiguration -Mailbox $mailbox.Identity -Identity Configuration\IPM.Configuration.OWA.ViewStateConfiguration -Confirm:$false
}