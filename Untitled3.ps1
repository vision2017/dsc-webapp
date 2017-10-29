
Function Set-SMTPSettings
{
    <#
    .SYNOPSIS
        Helper function used to set the SMTP server settings.
    .PARAMETER ID
        Specifies the ID of the SMTP virtual server. 1 is the default SMTP server.
    .PARAMETER Setting
        Specifies the setting of the SMTP virtual server to be changed.
    .PARAMETER Value
        Specifies the value of the SMTP virtual server setting to be changed.
    .NOTES
        All it does is wrap a [ASDI] call. Also this is used to allow pester to mock this call
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String] $Name,
        
        [Parameter(Mandatory = $true)]
        [String] $Setting,
        
        [Parameter(Mandatory = $true)]
        [String] $Value
    )
    
    $SMTPSite = Get-WmiObject IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2" | Where-Object { $_.name -like "SmtpSVC/${Name}" }
    $SMTPSite.$Setting=$Value
    $SMTPSite.Put()
}
Set-SMTPSettings 1 "HopCount" "193"