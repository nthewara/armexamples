$resourceGroupName = ""
$azfirewallname = "" 
$vnetname = ""
$publicIpAddressName = $azfirewallname+"-pip01"
$templateFilePath = ""
$parameterfile = ""

#Validate
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -TemplateParameterFile $paramfile -azureFirewallName $azfirewallname -virtualNetworkName $vnetname -publicipaddressname $publicIpAddressName

#deploy
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -TemplateParameterFile $paramfile -azureFirewallName $azfirewallname -virtualNetworkName $vnetname -publicipaddressname $publicIpAddressName

