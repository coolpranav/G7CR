
function Get-ARMVM
{
  $RGs = Get-AzResourceGroup
  foreach($RG in import-csv "C:\Users\User\OneDrive\Clients\TTK\Data4.csv")
  {
    $VMs = Get-AzVM -ResourceGroupName $RG.Rgroup
    foreach($VM in $VMs)
    {
      $VMDetail = Get-AzVM -ResourceGroupName $RG.Rgroup -Name $VM.Name -Status
      $RGN = $VMDetail.ResourceGroupName  
      foreach ($VMStatus in $VMDetail.Statuses)
      { 
          $VMStatusDetail = $VMStatus.DisplayStatus
      }
      $output = new-object psobject
 $output | add-member noteproperty ResourceGroupName "$RGN"
 $output | add-member noteproperty VMName $VM.Name
 $output | add-member noteproperty Status "$VMStatusDetail"
 Write-Output $output
      
    }
  }
}

$t = Get-ARMVM 

