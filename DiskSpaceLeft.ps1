Get-WmiObject -Class Win32_logicaldisk -Filter "DriveType = '3'" |
>> Select-Object -Property DeviceID, DriveType, VolumeName,
>> @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}},
>> @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}}

