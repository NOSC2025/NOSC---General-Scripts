# Connect to Exchange Online
Connect-ExchangeOnline

# Prompt for User B's email
$userB = Read-Host -Prompt "Enter the email address of the user you want to share calendars with"

# Initialize an empty array for User A's emails
$userAArray = @()

# Loop to add User A's emails
do {
    # Prompt for a User A's email
    $userA = Read-Host -Prompt "Add target user to share calendar with $userB"
    # Add the email to the array
    $userAArray += $userA
    # Ask if the user wants to add another email
    $addMore = Read-Host -Prompt "Do you want to add another user to check? (A for add new user, N for no)"
} while ($addMore -eq 'A')

# Iterate through each User A and add calendar sharing permissions
foreach ($userA in $userAArray) {
    Add-MailboxFolderPermission -Identity "${userA}:\Calendar" -User $userB -AccessRights Editor -Confirm:$false
}

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false

