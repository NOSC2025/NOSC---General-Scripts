param(                        
    [switch]$nodebug = $false,   ## if -nodebug parameter don't prompt for input
    [switch]$txt = $false        ## if -txt parameter used then record transcript
)
<#CIAOPS

Script provided as is. Use at own risk. No guarantees or warranty provided.

Description - Enable ligitigatin hold for all mailboxes
Documentation - https://github.com/directorcia/patron/wiki/Enable-litigation-hold
Source - https://github.com/directorcia/patron/blob/master/o365-mx-legal-set.ps1

Prerequisites = 1
1. Ensure connected to Exchange Online - Use the script https://github.com/directorcia/Office365/blob/master/o365-connect-exo.ps1

#>

## Variables
$systemmessagecolor = "cyan"
$processmessagecolor = "green"

Clear-Host
If ($txt) {start-transcript "..\o365-mx-legal-set $(get-date -f yyyyMMddHHmmss).txt"}

Write-Host -ForegroundColor $systemmessagecolor "Script started`n"

$mailboxes=Get-Mailbox -ResultSize unlimited -Filter {(RecipientTypeDetails -eq 'UserMailbox')} 


foreach ($mailbox in $mailboxes){
    write-host -foregroundcolor gray -BackgroundColor Black "Mailbox =",$mailbox.displayname

    ## Set retention period to maximum
    Write-host -ForegroundColor $processmessagecolor "    Enable legal hold"
    set-mailbox -identity $mailbox.userprincipalname -litigationholdenabled $true
 
    Write-Host
    If ($nodebug -eq $false) {Read-Host -Prompt "Press Enter to continue"}           ## If debug disabled then don't prompt
}

Write-Host -ForegroundColor $systemmessagecolor "Script Finished`n"

If ($txt) {stop-transcript}