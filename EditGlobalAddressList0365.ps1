Set-ExecutionPolicy RemoteSigned
Install-Module -Name ExchangeOnlineManagement
Connect-ExchangeOnline

 

$csvFileLocation = "C:\Users\Pranav Kumar\Desktop\OneDrive.csv"
$users = Import-Csv -Path $csvFileLocation
foreach ($user in $users) {$upn = $user.'Identity'; $manager = $user.'Manager';

 

Set-User -Identity $upn -Manager $manager 
}
