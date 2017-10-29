$argsInput=1
$metapath="IIS://localhost/smtpsvc/1"

if($argsInput -eq 1)
{
   GetAcl($metapath)
   exit 1
}
function GetAcl($metapath)
{
Write-Host $metapath
}

 $vSMTPServer.Properties | Foreach-Object{
   if($_.IsArray)
   {
        "`t[Write] "+$_.Type+' '+$_.Name+'[];'
   }
   else
   {
        "`t[Write] "+$_.Type+' '+$_.Name+';'
   }
   
   } | Out-File "C:\Users\p0rest\Downloads\smtpProperties.txt" 

$vSMTPServer.Properties | Foreach-Object{
   if($_.IsArray)
   {
        "`t`t`t"+$_.Name+"`t= `$CurrentSMTP."+$_.Name
   }
   else
   {
        "`t`t`t"+$_.Name+"`t= `$CurrentSMTP."+$_.Name
   }
   
   } | Out-File "C:\Users\p0rest\Downloads\smtpPropertiesT.txt" 


      $vSMTPServer.Properties | Foreach-Object{
   if($_.IsArray)
   {
        "`t`t@{`r`n`t`t`tName`t= '"+$_.Name+"'`r`n`t`t`tSource`t= '`$CurrentSMTP."+$_.Name+"'`r`n`t`t`tType`t= '"+$_.Type+"[]'`r`n`t`t}"
   }
   else
   {
        "`t`t@{`r`n`t`t`tName`t= '"+$_.Name+"'`r`n`t`t`tSource`t= '`$CurrentSMTP."+$_.Name+"'`r`n`t`t`tType`t= '"+$_.Type+"'`r`n`t`t}"
   }
   
   } | Out-File "C:\Users\p0rest\Downloads\smtpPropertiesT.txt" 

      $vSMTPServer.Properties | Foreach-Object{
   if($_.IsArray)
   {
        "`t`t["+$_.Type+"[]]`r`n`t`t`$"+$_.Name+",`r`n"
   }
   else
   {
        "`t`t["+$_.Type+"]`r`n`t`t`$"+$_.Name+",`r`n"
   }
   
   } | Out-File "C:\Users\p0rest\Downloads\smtpPropertiesK.txt" 