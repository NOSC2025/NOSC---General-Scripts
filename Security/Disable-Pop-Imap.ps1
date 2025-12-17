param(                        
    [switch]$nodebug = $false,   ## if -nodebug parameter don't prompt for input
    [switch]$txt = $false        ## if -txt parameter used then record transcript
)
<#CIAOPS

Script provided as is. Use at own risk. No guarantees or warranty provided.

Description - Disables POP and IMAP for all existing mailboxes as well as for any new mailboxes created as well
Documentation - https://github.com/directorcia/patron/wiki/Disable-IMAP-and-POP-on-all-Exchange-Online-mailboxes
Source - https://github.com/directorcia/patron/blob/master/o365-mx-popimap-disable.ps1

Prerequisites = 1
1. Ensure connected to Exchange Online - Use the script https://github.com/directorcia/Office365/blob/master/o365-connect-exo.ps1

#>

## Variables
$systemmessagecolor = "cyan"
$processmessagecolor = "green"
$pass = "(.)"

Clear-Host
If ($txt) {start-transcript "..\o365-mx-popimap $(get-date -f yyyyMMddHHmmss).txt"}

Write-Host -ForegroundColor $systemmessagecolor "Script started`n"

$mailboxes=get-mailbox -ResultSize unlimited

foreach ($mailbox in $mailboxes){
    write-host -foregroundcolor gray -BackgroundColor Black "Mailbox =",$mailbox.displayname

    ## Disable mailbox POP3
    Write-host -ForegroundColor $processmessagecolor "    Disable POP3",$pass
    set-casmailbox $mailbox.userprincipalname -popenabled $false -WarningAction SilentlyContinue
 
    ## Disable mailbox IMAP
    Write-host -ForegroundColor $processmessagecolor "    Disable IMAP",$pass
    set-casmailbox $mailbox.userprincipalname -imapenabled $false -WarningAction SilentlyContinue
    Write-Host
    If ($nodebug -eq $false) {Read-Host -Prompt "Press Enter to continue"}           ## If debug disabled then don't prompt
}

## Disable IMAP and POP3 for new users for all mailbox plans
Write-host -ForegroundColor $processmessagecolor "Start - Disable IMAP and POP3 for all new mailboxes"
Get-CASMailboxPlan | Set-CASMailboxPlan -ImapEnabled $false -PopEnabled $false
Write-host -ForegroundColor $processmessagecolor "Finish - Disable IMAP and POP3 for all new mailboxes`n"

Write-Host -ForegroundColor $systemmessagecolor "Script Finished`n"

If ($txt) {stop-transcript}
