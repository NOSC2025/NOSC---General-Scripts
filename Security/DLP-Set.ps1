<#
Description - Designed to add default DLP policies to tenant
Documentation - https://github.com/directorcia/patron/wiki/Add-default-Data-Loss-Protection-(DLP)-policies-to-tenant
Source - https://github.com/directorcia/patron/blob/master/o365-dlp-set.ps1

Prerequisites = 1
# 1. Ensure Security and Compliance module installed or updated - Use the script - https://github.com/directorcia/Office365/blob/master/o365-connect-sac.ps1
#>

## Variables
$systemmessagecolor = "cyan"
$processmessagecolor = "green"
$errormessagecolor = "red"

$mincount="1"
$maxcount="-1" ## = any
$minconfidence = "75"
$maxconfidence = "100"

## If you have running scripts that don't have a certificate, run this command once to disable that level of security
## set-executionpolicy -executionpolicy bypass -scope currentuser -force

Clear-Host

write-host -foregroundcolor $systemmessagecolor "Script started`n"

do {
    $siteadmin = read-host -Prompt "Enter Site admin email address to receive DLP reports"
} until (-not [string]::isnullorempty($siteadmin))

$checkpolicy = Get-dlpcompliancepolicy                ## get existing policies

## Configure Australian Privacy Act Policy
write-host -foregroundcolor $processmessagecolor "Start - Australian Privacy Act Policy"
if ($checkpolicy.name -contains "Australian Privacy Act"){            ## Does an existing spam policy of same name already exist?
    write-host -ForegroundColor $errormessagecolor ("Australian Privacy Act policy already exists - No changes made")
} else {  
    $params = @{
    'Name' = 'Australian Privacy Act';
    'ExchangeLocation' ='All';
    'OneDriveLocation' = 'All';
    'SharePointLocation' =  'All';
    'TeamsLocation' = 'All';
    'Mode' = 'Enable'
    }
    $result=new-dlpcompliancepolicy @params

    $senstiveinfo = @(@{Name ="Australia Driver's License Number"; minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'},@{Name ="Australia Passport Number";minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'})

    $Rulevalue = @{ 
    'Name' = 'Low volume of content detected Australia Privacy Act';
    'Comment' =  "Helps detect the presence of information commonly considered to be subject to the privacy act in Australia, like driver's license and passport number.";
    'Policy' = 'Australian Privacy Act';
    'ContentContainsSensitiveInformation'=$senstiveinfo;
    'BlockAccess' = $true;
    'AccessScope'='NotInOrganization';
    'BlockAccessScope'='All';
    'Disabled'=$false;
    'GenerateAlert'= $siteadmin;
    'GenerateIncidentReport'= $siteadmin;
    'IncidentReportContent'='All';
    'NotifyAllowOverride'='FalsePositive,WithJustification';
    'NotifyUser'='Owner','LastModifier',$siteadmin
    }
    $result=New-dlpcompliancerule @rulevalue -warningaction "SilentlyContinue"
}
write-host -foregroundcolor $processmessagecolor "Finish - Australian Privacy Act Policy`n"

## Configure Australian Financial Data Policy
write-host -foregroundcolor $processmessagecolor "Start - Australian Financial Data Policy"
if ($checkpolicy.name -contains "Australian Financial Data"){            ## Does an existing spam policy of same name already exist?
    write-host -ForegroundColor $errormessagecolor ("Australian Financial Data policy already exists - No changes made")
} else {  
    $params = @{
    'Name' = 'Australian Financial Data';
    'ExchangeLocation' ='All';
    'OneDriveLocation' = 'All';
    'SharePointLocation' =  'All';
    'TeamsLocation' = 'All';
    'Mode' = 'Enable'
    }
    $result=new-dlpcompliancepolicy @params

    $senstiveinfo = @(@{Name ="SWIFT Code"; minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'},@{Name ="Australia Tax File Number";minCount = $mincount; maxcount = $maxcount; minconfidence = $minconfidence; maxconfidence = $maxconfidence},@{Name ="Australia Bank Account Number";minCount = $mincount; maxcount = $maxcount; minconfidence = $minconfidence; maxconfidence = $maxconfidence},@{Name ="Credit Card Number";minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'})

    $Rulevalue = @{ 
    'Name' = 'Low volume of content detected Australia Financial Data';
    'Comment' =  "Helps detect the presence of information commonly considered to be financial data in Australia, including credit cards, and SWIFT codes.";
    'Policy' = 'Australian Financial Data';
    'ContentContainsSensitiveInformation'=$senstiveinfo;
    'BlockAccess' = $true;
    'AccessScope'='NotInOrganization';
    'BlockAccessScope'='All';
    'Disabled'=$false;
    'GenerateAlert'= $siteadmin;
    'GenerateIncidentReport'= $siteadmin;
    'IncidentReportContent'='All';
    'NotifyAllowOverride'='FalsePositive,WithJustification';
    'NotifyUser'='Owner','LastModifier', $siteadmin
    }
    $result=New-dlpcompliancerule @rulevalue -warningaction "SilentlyContinue"
}
write-host -foregroundcolor $processmessagecolor "Finish - Australian Financial Data Policy`n"

## Configure Australian Personally Identifable Information (PII) Data policy
write-host -foregroundcolor $processmessagecolor "Start - Australian Identifable Information (PII) Data Policy"
if ($checkpolicy.name -contains "Australian Personally Identifiable"){            ## Does an existing spam policy of same name already exist?
    write-host -ForegroundColor $errormessagecolor ("Australian Personally Identifiable policy already exists - No changes made")
} else {  
    $params = @{
    'Name' = 'Australian Personally Identifiable';
    'ExchangeLocation' ='All';
    'OneDriveLocation' = 'All';
    'SharePointLocation' =  'All';
    'TeamsLocation' = 'All';
    'Mode' = 'Enable'
    }
    $result=new-dlpcompliancepolicy @params

    $senstiveinfo = @(@{Name ="Australia Passport Number";minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'},@{Name ="Australia Driver's License Number";minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'})

    $Rulevalue = @{ 
    'Name' = 'Low volume of content detected Australia Personally Identifiable';
    'Comment' =  "Helps detect the presence of information commonly considered to be subject to the privacy act in Australia, like driver's license and passport number.";
    'Policy' = 'Australian Personally Identifiable';
    'ContentContainsSensitiveInformation'=$senstiveinfo;
    'BlockAccess' = $true;
    'AccessScope'='NotInOrganization';
    'BlockAccessScope'='All';
    'Disabled'=$false;
    'GenerateAlert'= $siteadmin;
    'GenerateIncidentReport'= $siteadmin;
    'IncidentReportContent'='All';
    'NotifyAllowOverride'='FalsePositive,WithJustification';
    'NotifyUser'='Owner','LastModifier', $siteadmin
    }
    $result=New-dlpcompliancerule @rulevalue -warningaction "SilentlyContinue"
}
write-host -foregroundcolor $processmessagecolor "Finish - Australian Identifable Information (PII) Data Policy`n"

## Configure Australian Health Records Act (HRIP Act)
write-host -foregroundcolor $processmessagecolor "Start - Australian Health Records Act Policy"
if ($checkpolicy.name -contains "Australian Health Records Act (HRIP Act)"){            ## Does an existing spam policy of same name already exist?
    write-host -ForegroundColor $errormessagecolor ("Australian Health Records Act (HRIP Act) policy already exists - No changes made")
} else {  
    $params = @{
    'Name' = 'Australian Health Records Act (HRIP Act)';
    'ExchangeLocation' ='All';
    'OneDriveLocation' = 'All';
    'SharePointLocation' =  'All';
    'TeamsLocation' = 'All';
    'Mode' = 'Enable'
    }
    $result=new-dlpcompliancepolicy @params

    $senstiveinfo = @(@{Name ="Australia Tax File Number";minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'},@{Name ="Australia Medical Account Number";minCount = $mincount; maxcount = $maxcount; confidencelevel = 'High'})

    $Rulevalue = @{ 
    'Name' = 'Low volume of content detected Australia Health Records';
    'Comment' =  "Helps detect the presence of information commonly considered to be subject to the Health Records and Information Privacy (HRIP) act in Australia, like medical account number and tax file number.";
    'Policy' = 'Australian Health Records Act (HRIP Act)';
    'ContentContainsSensitiveInformation'=$senstiveinfo;
    'BlockAccess' = $true;
    'AccessScope'='NotInOrganization';
    'BlockAccessScope'='All';
    'Disabled'=$false;
    'GenerateAlert'= $siteadmin;
    'GenerateIncidentReport'= $siteadmin;
    'IncidentReportContent'='All';
    'NotifyAllowOverride'='FalsePositive,WithJustification';
    'NotifyUser'='Owner','LastModifier', $siteadmin
    }
    $result=New-dlpcompliancerule @rulevalue -warningaction "SilentlyContinue"
}
write-host -foregroundcolor $processmessagecolor "Finish - Australian Health Records Act Policy`n"

write-host -foregroundcolor $systemmessagecolor "Script Finished`n"
