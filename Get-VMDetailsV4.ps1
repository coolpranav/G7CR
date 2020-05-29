foreach($DATA in import-csv "C:\Users\User\OneDrive\Clients\ilantus\Data4.csv")
{$VM = Get-AzVM -VMName $DATA.VMNAME -ResourceGroupName $DATA.Rgroup
 if($VM.HardwareProfile -like "B")
{
 write "this is B series"
 }
 else
 {
 $out = new-object psobject
 $out | add-member noteproperty VMName $VM.Name
 $out | add-member noteproperty VmSize $VM.HardwareProfile.VmSize
 Write-Output $out 
 }
 }




