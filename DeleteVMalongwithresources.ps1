#Write-Host -NoNewline -ForegroundColor Green "Please enter the VM name you would like to remove:"
#$VMName = Read-Host
$csvFileLocation = "C:\Users\User\Desktop\VMName.csv"
$VMNameList = Import-Csv -Path $csvFileLocation
#$VMNameList.VMName
foreach ($VMName in $VMNameList.VMName)

{


###################################################################################################################
$vm = Get-AzVm -Name $VMName
if ($vm) {

$RGName=$vm.ResourceGroupName
Write-Host -ForegroundColor Cyan 'Resource Group Name is identified as-' $RGName

#$diagSa = [regex]::match($vm.DiagnosticsProfile.bootDiagnostics.storageUri, '^http[s]?://(.+?)\.').groups[1].value

Write-Host -ForegroundColor Cyan 'Marking Disks for deletion...'

$tags = @{"VMName"=$VMName; "Delete Ready"="Yes"}
$osDiskName = $vm.StorageProfile.OSDisk.Name
$datadisks = $vm.StorageProfile.DataDisks
$ResourceID = (Get-Azdisk -Name $osDiskName).id

###################################################################


<#New-AzTag -ResourceId $ResourceID -Tag $tags | Out-Null
if ($vm.StorageProfile.DataDisks.Count -gt 0) {
    foreach ($datadisks in $vm.StorageProfile.DataDisks){
    $datadiskname=$datadisks.name
    $ResourceID = (Get-Azdisk -Name $datadiskname).id
    New-AzTag -ResourceId $ResourceID -Tag $tags | Out-Null
    }
}#>

####################################################################################################
#if ($vm.Name.Length -gt 9){
 #   $i = 9
  #  }
  #  else
   # {
   # $i = $vm.Name.Length - 1
#}
##########################################################################################################
$azResourceParams = @{
 'ResourceName' = $VMName
 'ResourceType' = 'Microsoft.Compute/virtualMachines'
 'ResourceGroupName' = $RGName
}

<#$vmResource = Get-AzResource @azResourceParams
$vmId = $vmResource.Properties.VmId
#$diagContainerName = ('bootdiagnostics-{0}-{1}' -f $vm.Name.ToLower().Substring(0, $i), $vmId)
$diagSaRg = (Get-AzStorageAccount | where { $_.StorageAccountName -eq $diagSa }).ResourceGroupName
$saParams = @{
  'ResourceGroupName' = $diagSaRg
  'Name' = $diagSa
  
}#>
#Write-Host -ForegroundColor Cyan 'Removing Boot Diagnostic disk..'
#if ($diagSa){
#Get-AzStorageAccount @saParams | Get-AzStorageContainer | where {$_.Name-eq $diagContainerName} | Remove-AzStorageContainer -Force
#}
<#else {
Write-Host -ForegroundColor Green "No Boot Diagnostics Disk found attached to the VM!"
}#>



###############################################################################################################

Write-Host -ForegroundColor Cyan 'Removing Virtual Machine-' $VMName 'in Resource Group-'$RGName '...'
$null = $vm | Remove-AzVM -Force

###############################################################################################################

Write-Host -ForegroundColor Cyan 'Removing Network Interface Cards, Public IP Address(s) used by the VM...'
foreach($nicUri in $vm.NetworkProfile.NetworkInterfaces.Id) {
   $nic = Get-AzNetworkInterface -ResourceGroupName $vm.ResourceGroupName -Name $nicUri.Split('/')[-1]
   Remove-AzNetworkInterface -Name $nic.Name -ResourceGroupName $vm.ResourceGroupName -Force
   foreach($ipConfig in $nic.IpConfigurations) {
     if($ipConfig.PublicIpAddress -ne $null){
     Remove-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName -Name $ipConfig.PublicIpAddress.Id.Split('/')[-1] -Force
     }
    }
}

###############################################################################################################

Write-Host -ForegroundColor Cyan 'Removing OS disk and Data Disk(s) used by the VM..'
Remove-AzDisk -ResourceGroupName $RGName -DiskName $osDiskName -Force
#Get-AzResource -tag $tags | where{$_.resourcegroupname -eq $RGName}| Remove-AzResource -force | Out-Null
Write-Host -ForegroundColor Green 'Azure Virtual Machine-' $VMName 'and all the resources associated with the VM were removed sucesfully...'
}
else{
Write-Host -ForegroundColor Red "The VM name entered doesn't exist in your connected Azure Tenant! Kindly check the name entered and restart the script with correct VM name..."
}
}
