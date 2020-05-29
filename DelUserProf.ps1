
$userprofile=Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -ne 'azureadmin' }|Remove-CimInstance