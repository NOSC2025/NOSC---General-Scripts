# Define the backup directory
$backupDir = (Get-Location).Path

# Load the GroupPolicy module
Import-Module GroupPolicy

# Function to sanitize file names
function Sanitize-FileName {
    param (
        [string]$name
    )
    $invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
    foreach ($char in $invalidChars) {
        $name = $name -replace [regex]::Escape($char), ''
    }
    return $name
}

# Get all GPOs in the domain
$gpos = Get-GPO -All

# Loop through each GPO and export it to XML
foreach ($gpo in $gpos) {
    $gpoName = Sanitize-FileName -name $gpo.DisplayName
    $gpoId = $gpo.Id
    $xmlPath = "$backupDir\$gpoName.xml"
    
    # Export the GPO to XML
    Get-GPOReport -Guid $gpoId -ReportType XML -Path $xmlPath
}

Write-Output "Backup completed. All GPOs have been exported to XML format in the directory: $backupDir"
