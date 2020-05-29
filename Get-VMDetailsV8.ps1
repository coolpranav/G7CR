$report = @()
$vms = get-azvm
$nics = get-aznetworkinterface | ?{ $_.VirtualMachine -NE $null}
 
foreach($nic in $nics)
{
    $info = "" | Select VmName, ResourceGroupName, HostName, IpAddress
    $vm = $vms | ? -Property Id -eq $nic.VirtualMachine.id
    $info.VMName = $vm.Name
    $info.ResourceGroupName = $vm.ResourceGroupName
    $info.IpAddress = $nic.IpConfigurations.PrivateIpAddress
    $info.HostName = $vm.OSProfile.ComputerName
    $report+=$info
}
$report | Export-Csv C:\Users\User\Desktop\VMDETAILS.csv -NoTypeInformation
