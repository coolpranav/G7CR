#Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com"
$ErrorActionPreference=“silentlycontinue”

 

$Tenant=Get-RdsTenant

 

Foreach($TenantN in $Tenant)
{
$TenantName=$TenantN.TenantName

 

Write-Host "Tenant Name $TenantName" -ForegroundColor Green

Connect-AzAccount
$HostPoolName=Get-RdsHostPool -TenantName $TenantName | Select-Object HostPoolName
$HostPools=$HostPoolName.HostPoolName
Foreach($Hostpool in $HostPools)
{
$date=Get-date
$date=Get-date $date -Format dd-MM-yyyy-hh-mm
$Hostpool
$test=Get-RdsUserSession -TenantName $TenantName -HostPoolName $Hostpool|Export-Csv "C:\Swiggy(Bundle)\Usersession-$date.csv"

 

Get-RdsSessionHost -TenantName $TenantName -HostPoolName $HostPoolName |Export-Csv "C:\Swiggy(Bundle)\SessionHost-$date.csv" 

 

}
}
