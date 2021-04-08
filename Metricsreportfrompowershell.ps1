Login-AzAccount
mkdir -P D:\CLIENTNAME\
#Put your all VM name and the Resource group where it belongs to one CSV and you can do it from portal i.e., Export to CSV.
foreach($VM in import-csv "D:\Clients\Data3.csv")
{
$n= $VM.Name
$n
mkdir $n
$m= $VM.RESOURCEGROUP
$Metric=Get-AzMetric  -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName  'Percentage CPU' -AggregationType Maximum -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00
$Metric1=Get-AzMetric -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName 'Network In Total' -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00
$Metric2=Get-AzMetric -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName 'Network Out Total' -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00
$Metric3=Get-AzMetric -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName 'Disk Read Bytes' -AggregationType Maximum -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00
$Metric4=Get-AzMetric -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName 'Disk Write Bytes' -AggregationType Maximum -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00
$Metric5=Get-AzMetric -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName 'Disk Read Operations/Sec' -AggregationType Maximum -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00
$Metric6=Get-AzMetric -ResourceId /subscriptions/l56fd102-5457-4401-8ed5-adfb8b210bfc/resourceGroups/$m/providers/Microsoft.Compute/virtualMachines/$n -MetricName 'Disk Write Operations/Sec' -AggregationType Maximum -StartTime 2021-04-06T00:32:00Z -EndTime 2021-04-06T16:37:00Z -TimeGrain 00:05:00

$Metric.Data | Export-Csv  D:\CLIENTNAME\$n\PERCENTAGECPU.csv
$Metric1.Data | Export-Csv D:\CLIENTNAME\$n\NETWORKINTOTAL.csv
$Metric2.Data | Export-Csv D:\CLIENTNAME\$n\NETWORKOUTTOTAL.csv
$Metric3.Data | Export-Csv D:\CLIENTNAME\$n\DISKREADBYTES.csv
$Metric4.Data | Export-Csv D:\CLIENTNAME\$n\DISKWRITEBYTES.csv
$Metric5.Data | Export-Csv D:\CLIENTNAME\$n\DISKREADOPERATION-SEC.csv
$Metric6.Data | Export-Csv D:\CLIENTNAME\$n\DISKWRITEOPERATION-SEC.csv
}
