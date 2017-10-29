Configuration SMTPDemo
{
	

Import-DscResource -ModuleName PSDesiredStateConfiguration, xWebAdministration

    Node localhost
    {
		<#WindowsFeature SmtpServer 
		{
			 Name = "Smtp-Server"
			 Ensure = "Present"
		}
        WindowsFeature WebScriptingTools 
		{
			 Name = "Web-Scripting-Tools"
			 Ensure = "Present"
		}
        WindowsFeature WebWMI 
		{
			 Name = "Web-WMI"
			 Ensure = "Present"
		}#>
        xSMTP SmtpSetting
        {
           ID = 1
           SmartHost = "test.gret"
           HopCount = "1"
        }
        <#Service SmtpService
        {
            Name        = "SMTPSVC"
            StartupType = "Automatic"
            State       = "Running"
        }#>


    }
}

SMTPDemo
Start-DscConfiguration localhost -Path "C:\Program Files\WindowsPowerShell\Modules\xWebAdministration\DSCResources\SMTPDemo" -wait -Force