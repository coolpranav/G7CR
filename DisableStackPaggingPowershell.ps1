foreach($VM in import-csv "C:\Users\User\Desktop\Swiggy.csv")
{$ARMVM = Get-AzVM -VMName $VM.VMNAME -ResourceGroupName $VM.Rgroup
Invoke-AzVMRunCommand -ResourceGroupName  $VM.Rgroup  -VMName  $VM.VMNAME -CommandId 'RunPowerShellScript' -ScriptPath 'C:\Users\User\Desktop\disablestackpaging.ps1'}
