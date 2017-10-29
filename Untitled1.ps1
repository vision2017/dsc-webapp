$SMTPSite = [ADSI]"IIS://localhost/smtpsvc/1"
$SMTPSite.SmartHost
$SMTPSite.Put("SmartHost", "Test.testes.test")
    $SMTPSite.SetInfo()

    $SMTPSite | Get-Member | Where-Object {$_.MemberType -like 'Property' }

    $virtualSMTPServer = Get-WmiObject IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2" | Where-Object { $_.name -like "SmtpSVC/1" }

    (($virtualSMTPServer | Get-Member | Where-Object {$_.MemberType -like 'Property' }).Name).Length
    (Get-WmiObject IISSmtpServerSetting -namespace "ROOT\MicrosoftIISv2" | Where-Object { $_.name -like "SmtpSVC/1" }).GetSecurityDescriptor()

   (Get-WmiObject IIsAdminACL_IIsACE -namespace "ROOT\MicrosoftIISv2").GetType()
   $names=(Get-CimInstance IIsACE -namespace "ROOT\MicrosoftIISv2"  | Where-Object {$_.Name -like "*SmtpSvc/1*"} | Group-Object -Property Name).Name
   
   $names | ForEach-Object {Set-WmiInstance IIsACE -namespace "ROOT\MicrosoftIISv2" -Arguments @{Name=$_;Trustee="vmtest\p0rest";AccessMask=262315;AceFlags=0;AceType=0}
   }
   Set-WmiInstance IIsACE -namespace "ROOT\MicrosoftIISv2" -Arguments @{Name="SmtpSvc/1/User";Trustee="vmtest\p0rest";AccessMask=262315;AceFlags=0;AceType=0}
   $SMTPSite.SetInfo()


   $names | ForEach-Object { Get-WmiObject -Query "SELECT * FROM IIsACE WHERE Name='$_' AND Trustee='VMTest\\p0rest'" -Namespace "ROOT\MicrosoftIISv2" |Remove-WmiObject}