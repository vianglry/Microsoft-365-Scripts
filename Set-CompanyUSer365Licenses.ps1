function Set-TFIUser365License {
    Param (
        [string]$UserEmail
    )

    $MS365E3License = 'Company:SPE_E3' 
    $MS365DefenderLicense = 'Company:ATP_ENTERPRISE'
    $UnitedStates = 'US'

    #Connect to 365 mail and license service
    Write-host Connecting to Office365
    Start-Sleep 5
    Connect-MsolService

    Set-MsolUser -UserPrincipalName $UserEmail -UsageLocation $UnitedStates
    Set-MsolUserLicense -UserPrincipalName $UserEmail -AddLicenses $MS365E3License
    Set-MsolUserLicense -UserPrincipalName $UserEmail -AddLicenses $MS365DefenderLicense

    $Need365AudioLic = Read-host "Does the user need a Microsoft Audio License [Y/N]"
    If ($Need365AudioLic -eq 'Y') {
        Set-MsolUserLicense -UserPrincipalName $UserEmail -AddLicenses $MS365AudioConferencingLicense
    }
}