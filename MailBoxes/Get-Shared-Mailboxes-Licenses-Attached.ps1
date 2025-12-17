# Connect to Exchange Online using administrator credentials
Connect-ExchangeOnline -UserPrincipalName nosc@Link-Resources.com.au

# Retrieve all shared mailboxes in the organization
$sharedMailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox

# Filter shared mailboxes that also have a license assigned
$licensedSharedMailboxes = foreach ($mailbox in $sharedMailboxes) {
    # Get user details for each shared mailbox
    $user = Get-User -Identity $mailbox.UserPrincipalName
    
    # Check if the user has a license (SKUAssigned property)
    if ($user.SKUAssigned) { $mailbox }
}

# Define the output file path
$outputPath = "C:\NOSC\LicensedSharedMailboxes.csv"

# Export the filtered list of licensed shared mailboxes to a CSV file
$licensedSharedMailboxes | Select DisplayName, UserPrincipalName | Export-Csv -Path $outputPath -NoTypeInformation

# Notify user of successful CSV export
Write-Host "CSV file saved to $outputPath"

# Disconnect the Exchange Online session
Disconnect-ExchangeOnline -Confirm:$false
