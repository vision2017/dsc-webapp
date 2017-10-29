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