Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] [Parameter(Mandatory=$true)] $vnetname
)

#Variables
$Randomstring = -join ((97..122) | Get-Random -Count 8 | % {[char]$_})

#Azuredeployment parameters
$azfirewallname = "azfw-"+$Randomstring 
$publicIpAddressName = $azfirewallname+"-pip01"

#Template location (Github)
$templateFilePath = "https://raw.githubusercontent.com/nthewara/armexamples/master/Network/azureFirewalls/firewall.json"
$parameterfile = "https://raw.githubusercontent.com/nthewara/armexamples/master/Network/azureFirewalls/parameters.firewall.json"

#Validate
#Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateFilePath -TemplateParameterUri $paramfile -azureFirewallName $azfirewallname -virtualNetworkName $vnetname -publicipaddressname $publicIpAddressName

#deploy
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateFilePath -azureFirewallName $azfirewallname -virtualNetworkName $vnetname -publicipaddressname $publicIpAddressName

