# Script to automate the migration from DvS / Or any Port-group / To N-VDS
# Created by Sorenisager, sorenisager.com - free to change.

# Variables
$SwitchDestinationName = "NSX_GLOBAL_IX_1110" # Destination NSX-T switch
$SourceSwitchName = "DvS_IX_GLOBAL" # Source switch
$ClusterToMigrate = "PROD_IX_WIN01" # Name of your cluster

# Get VMs
$vms = Get-VirtualPortGroup -name $SourceSwitchName | Get-VM  | Where-Object {$_.VMHost.Parent -like "$($ClusterToMigrate)"}

foreach ($vm in $vms)
  {
    # Set the new N-VDS Segment name
      $vm | Get-NetworkAdapter -NetworkName $SourceSwitchName | Set-NetworkAdapter -NetworkName $SwitchDestinationName -Confirm:$false
  } 
