#Remove Azure Monitor Extension from a VM 
Remove-AzVMExtension -ResourceGroupName ""  -Name "MicrosoftMonitoringAgent" -VMName "" -Force

#Remove Azure Monitor Extension from all VMs in a Resource Group 
$resourceGroupName = ""
get-azvm -ResourceGroupName $resourceGroupName | ForEach-Object {
    Remove-AzVMExtension -VMName $_.Name -ResourceGroupName $_.ResourceGroupName -Name "MicrosoftMonitoringAgent" -Force
}


