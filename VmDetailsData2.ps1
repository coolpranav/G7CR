[array]$VMs = Get-AzVm 

foreach ($VM in $VMs)
 {
Write-Output "VM: $($VM.Name)"
Write-Output "VM Size: $($VM.HardwareProfile.VmSize)"
 }