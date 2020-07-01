$TennantName = "#########"
$AppGroupName = "Desktop Application Group"
$HostPoolArray = Get-RdsHostPool -TenantName $TennantName |Select-Object HostPoolName
 
#Write-Host "Hostpoolname Hostname AssignedUser"
foreach ($HostPool in $HostPoolArray)
{
 #$UserCount =(Get-RdsAppGroupUser -TenantName $TennantName -HostPoolName $HostPool.HostPoolName -AppGroupName $AppGroupName).count
 $n=$HostPool.HostPoolName
 #Get-RdsSessionHost -TenantName $TennantName -HostPoolName $HostPool.HostPoolName
 Get-RdsSessionHost -TenantName $TennantName -HostPoolName $HostPool.HostPoolName|Select-Object HostPoolName,SessionHostName,AssignedUser |Export-Csv C:\Users\User\Music\$n.csv
 
 #$FreeMacCount =(Get-RdsSessionHost -TenantName $TennantName -HostPoolName $HostPool.HostPoolName | Where-Object {$_.AssignedUser -eq $null} |Select-Object SessionHostName).count
 #Write-Host $HostPool.HostPoolName.ToString() " " $UserCount.ToString() " " $HostCount.ToString() " " $AssignedCount " " $FreeMacCount
}
