# Connect to Exchange Online
Connect-ExchangeOnline

# Get target users email address
$targetUser = Read-Host -Prompt "Enter the target user's email address"

#Get target users email max send size and max recieve size
Get-Mailbox -Identity $targetUser | Select-Object Name, MaxSendSize, MaxReceiveSize

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false
