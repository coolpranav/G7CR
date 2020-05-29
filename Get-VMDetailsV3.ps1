$POVMs = Get-AzVM  | Where-Object {$VM.HardwareProfile.VmSize -inotlike 'Standard_B2s'}
$POVMs | Sort

$POVMs = Get-AzVM | Where-Object {$env:ALLUSERSPROFILE} | Where-Object {$VM.HardwareProfile -notlike 'Standard_B'}

$Hello = Get-AzVM
$Hello | ft ResourceGroupName,Name,

Get-AzVM | Where-Object {$env:ALLUSERSPROFILE}| ft Name,ResourceGroupName,{$VM.HardwareProfile.VmSize} | Export-FormatData C:\Users\User\Desktop\Nello
