foreach($VM in import-csv "C:\Users\User\Downloads\Bridestonestartek.csv")
{$ARMVM = Get-AzVM -VMName $VM.VMNAME -ResourceGroupName $VM.Rgroup
$ARMVM.HardwareProfile.VmSize = "Standard_B2ms"
Update-AzVM -VM $ArmVM -ResourceGroupName $VM.Rgroup 
}
