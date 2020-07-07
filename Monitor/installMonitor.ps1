#Install Azure Monitor Extension

$resourceGroupName = ""
$PublicSettings = @{"workspaceId" = ""}
$ProtectedSettings = @{"workspaceKey" = ""}
$vms=Get-AzVM -ResourceGroupName $resourceGroupName # | Where-Object {$_.name -match "DEMO"}    (This is an example if you want to further filter VMs by name)
$Location = ""
 
foreach($vm in $vms){
$vmName=$vm.name
 
Set-AzVMExtension -ExtensionName "MicrosoftMonitoringAgent" `
    -ResourceGroupName $resourceGroupName `
    -VMName $vmName `
    -Publisher "Microsoft.EnterpriseCloud.Monitoring" `
    -ExtensionType "MicrosoftMonitoringAgent" `
    -TypeHandlerVersion 1.0 `
    -Settings $PublicSettings `
    -ProtectedSettings $ProtectedSettings `
    -Location $Location
}