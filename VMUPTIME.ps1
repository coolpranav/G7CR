#Get-AzSubscription -SubscriptionId c2327cd8-9874-432f-9450-d308f1c583a9
Add-AzAccount
Select-AzSubscription -SubscriptionId c2327cd8-9874-432f-9450-d308f1c583a9
#$comparedate = (get-date).AddDays(-30)


#$t = Get-AzResourceGroup -ResourceGroupName

$vm1 = @() 
$r= Get-AzResourceGroup
#$r.ResourceGroupName
foreach($rg in $r.ResourceGroupName)
{
$vms = Get-AzVM -ResourceGroupName $rg -Status
#$vms.Name
foreach ($vm in $vms)
{
	# only check if the VM is running, because if it's off we don't care
	if ($vm.PowerState -ceq "VM running")
	{
    $foundvm= get-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status 
       
    $output = new-object psobject
    $output  | add-member noteproperty Name $foundvm.Name
    $output | add-member noteproperty StatusTime $foundvm.Statuses.Time[0]
    $output | add-member noteproperty TodaysTime $time
    $vm1+=$output
	}
}
}
$vm1 | Export-Excel C:\Users\User\Desktop\hello1.xlsx






#Get the Instance view of a collection of virtual machines (returns the PowerState property)
#$vms = get-azvm  -resourcegroup $rg -Status

#$vm1 = @()  
#$time = Get-Date -DisplayHint DateTime
#Iterate through the collection
<#foreach ($vm in $vms)
{
	# only check if the VM is running, because if it's off we don't care
	if ($vm.PowerState -ceq "VM running")
	{
    $foundvm= get-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Status 
       
    $output = new-object psobject
    $output  | add-member noteproperty Name $foundvm.Name
    $output | add-member noteproperty StatusTime $foundvm.Statuses.Time[0]
    $output | add-member noteproperty TodaysTime $time
    $vm1+=$output
	}
}
$vm1 | Export-Excel C:\Users\User\Desktop\hello.xlsx



#$date = (get-date)
#$d=$date.ToString("yyyy-MM-dd") 
#$d
#$mydate=($d).ToString("dd-MM-yyyy-hh-mm-ss")
#$mydate
#Get-Date -DisplayHint DateTime 
	# Get the instance view of a single virtual machine (returns the "statuses" object)
	#	$foundvm = getAzvm -resourcegroup $vm.ResourceGroupName -name $vm.Name -status
    #    $foundvm
		    #$foundvm.Statuses.Time
                # check if time since it was provisioned (in Statuses[0]) is greater than a value
<#		if ($foundvm.Statuses.Time -le $comparedate)
		{
			write-output "$($foundvm.name) : running longer than 30 days"
		}
	}
}#>#>
