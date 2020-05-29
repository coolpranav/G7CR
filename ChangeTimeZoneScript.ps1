foreach($VM in import-csv "C:\Users\User\OneDrive\Clients\Swiggy\Data3.csv")
{$ARMVM = Get-AzVM -VMName $VM.VMName -ResourceGroupName $VM.Rgroup
 
Invoke-AzVMRunCommand -ResourceGroupName  $VM.Rgroup  -VMName  $VM.VMName -CommandId 'RunPowerShellScript' -ScriptPath 'C:\Users\User\OneDrive\Sample\changetimezone.ps1' }
