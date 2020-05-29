#Logout-AzAccount
#Provide the subscription Id where the VMs reside

 

 

 

#Provide the name of the csv file to be exported
$reportName = "StartekmyReport.csv"

 

 

 

$report = @()
$vms = Get-AzurermVM
$vms | fl

 

 

 

foreach ($vm in $vms) { 

 

        $Memorysize = (Get-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name).HardwareProfile.VmSize
         #$VMmemory=Get-azurermvmsize -location $vm.Location  | ?{ $_.name -eq $size }

 

        $info = "" | select ResourceGroupName, VmName, Location, VmSize 
        $info.VmName = $vm.Name 
        $info.ResourceGroupName = $vm.ResourceGroupName 
        $info.Location = $vm.Location 
        $info.VmSize = $Memorysize
        $report+=$info 
    } 
$report | Export-CSV "C:\$reportName"
