param(                         
    [switch]$debug = $false, ## if -debug capture output to log file
    [switch]$prompt = $false   ## if -prompt prompt user for input
)
<# CIAOPS
Script provided as is. Use at own risk. No guarantees or warranty provided.

Description - Set OWA policy settings
Documentation - https://github.com/directorcia/patron/wiki/Set-OWA-policy-settings
Source - https://github.com/directorcia/patron/blob/master/m365-owapolicy-set.ps1

Prerequisites = 1
1. Connect to Office 365 Exchange Online - Use the script https://github.com/directorcia/Office365/blob/master/o365-connect-exo.ps1
#>

## Variables
$systemmessagecolor = "cyan"
$processmessagecolor = "green"
$errormessagecolor = "red"
$warningmessagecolor = "yellow"

Clear-Host
if ($debug) {
    # Measure script execution time
    $startTime = Get-Date

    start-transcript "..\m365-owapolicy-set.txt" | Out-Null
    write-host -foregroundcolor $processmessagecolor "[Info] = Script activity logged at ..\m365-owapolicy-set.txt`n"
}
else {
    write-host -foregroundcolor $processmessagecolor "[Info] = Debug mode disabled`n"
}
write-host -foregroundcolor $systemmessagecolor "Disable OWA policy settings script started`n"
if ($prompt) {
    write-host -foregroundcolor $processmessagecolor "[Info] = Prompt mode enabled"
}
else {
    write-host -foregroundcolor $processmessagecolor "[Info] = Prompt mode disabled"
}
write-host -foregroundcolor $processmessagecolor "[Info] = Checking PowerShell version"
$ps = $PSVersionTable.PSVersion
Write-host -foregroundcolor $processmessagecolor "- Detected supported PowerShell version: $($ps.Major).$($ps.Minor)"

If ($prompt) { Read-Host -Prompt "`n[PROMPT] -- Press Enter to continue" }

if (get-module -listavailable -name ExchangeOnlineManagement) {
    ## Has the Exchange Online PowerShell module been loaded?
    write-host -ForegroundColor $processmessagecolor "Exchange Online PowerShell found"
}
else {
    write-host -ForegroundColor yellow -backgroundcolor $errormessagecolor "[001] - Exchange Online PowerShell module not installed. Please install and re-run script`n"
    Stop-Transcript                 ## Terminate transcription
    if ($debug) {
        exit 1                          ## Terminate script
    }
}

write-host -foregroundcolor $processmessagecolor "OWA policy = OwaMailboxPolicy-Default"
write-host -foregroundcolor $processmessagecolor "  Additional storage providers available = false"
write-host -foregroundcolor $processmessagecolor "  LinkedIn connection = disabled"
write-host -foregroundcolor $processmessagecolor "  Facebook connection = disabled"
write-host -foregroundcolor $processmessagecolor "  ActiveSync integration = disabled"

$result = Set-OwaMailboxPolicy -Identity OwaMailboxPolicy-Default `
-AdditionalStorageProvidersAvailable $false `
-LinkedInEnabled $false `
-DisableFacebook `
-activeSyncIntegrationEnabled $false| Out-Null

write-host -foregroundcolor $systemmessagecolor "Disable OWA policy settings script finished`n"

If ($debug) { 
    $endTime = Get-Date
    $executionTime = $endTime - $startTime
    Write-Host "Script execution time: $executionTime"

    stop-transcript | Out-Null
}

