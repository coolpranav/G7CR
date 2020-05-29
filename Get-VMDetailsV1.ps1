$POVMs = Get-AzVM | Where-Object {$env:ALLUSERSPROFILE} | ft Name,ResourceGroupName,{$VM.HardwareProfile.VmSize}
$POVMs | Export-Csv C:\Users\User\Desktop\newlist.csv -NoTypeInformation
