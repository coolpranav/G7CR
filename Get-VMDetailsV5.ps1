
[array]$VMs = Get-AzVm

foreach ($VM in $VMs)
 {
 if($VM.HardwareProfile -like "B")
 {
 write "b series machine"
 }
 else{
 $out = new-object psobject
 $out | add-member noteproperty VMName $VM.Name
 $out | add-member noteproperty VmSize $VM.HardwareProfile.VmSize
 $out | add-member noteproperty VMResourceGroup $VM.ResourceGroupName
 Write-Output $out
 }
 }
 
 
