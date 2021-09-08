Get-AzSubscription -SubscriptionName WVDonCSP | Set-AzContext

# Create a credential
$AdminUser = 'g7problemtrackerdb'
$AdminPassword = ConvertTo-SecureString –String 'Pa55w.rd@1234' –AsPlainText -Force
$Credential = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $AdminUser, $AdminPassword

$storageAccountName = "wvdusersessionstg"
$ResourceGroupName = "WVDLogAnalyticsWorkspace"
(Get-AzStorageAccountKey -Name $storageAccountName -ResourceGroupName $ResourceGroupName)[0].value
$storagekey = 'cSG2jwuubMCFdlLV5iRUQj5e6qrhXWyvc/dwpUZtwYO+IS5mc2CwIzeqT3gyIwTcaEmOcAWgIdFCAXJMDcKwaQ=='
$context=New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey (Get-AzStorageAccountKey -Name $storageAccountName -ResourceGroupName $ResourceGroupName)[0].value
$container=Get-AzStorageContainer -Name $containername -Context $Context

New-AzStorageContainer -Name exportdemo -Context $context -Permission off
$storageURI=$container.CloudBlobContainer.Uri.OriginalString[1]+"/G7-ProblemTracker-DB.bacpac"

$ResourceGroupName = 'G7-ProblemTracker-RG'
$ServerName = 'g7problemtrackerdb.database.windows.net'
$DatabaseName = 'G7-ProblemTracker-DB'
$db = Get-AzSqlDatabase -ResourceGroupName G7-ProblemTracker-RG -DatabaseName G7-ProblemTracker-DB -ServerName g7problemtrackerdb

$export=New-AzSqlDatabaseExport -ResourceGroupName $db.ResourceGroupName -ServerName $db.ServerName -DatabaseName $db.DatabaseName -AdministratorLogin $Credential.UserName -AdministratorLoginPassword $Credential.Password -StorageKeyType StorageAccessKey -StorageUri $storageURI -StorageKey (Get-AzStorageAccountKey -Name $storageAccountName -ResourceGroupName $ResourceGroupName)[0].value
Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $export.OperationStatusLink
