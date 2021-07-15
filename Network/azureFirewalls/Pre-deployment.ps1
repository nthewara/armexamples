#This script can be used to create subnets 
#AzurefirewallSubnet needs to be a /26 


#Parameters
Param(
    [string] [Parameter(Mandatory=$true)] $resourceGroupName,
    [string] [Parameter(Mandatory=$true)] $virtualNetworkName,
    [string] [Parameter(Mandatory=$true)] $addressPrefix
)


$vnet = Get-AzVirtualNetwork -Name $virtualNetworkName -ResourceGroupName $resourceGroupName 
Add-AzVirtualNetworkSubnetConfig -Name AzureFirewallSubnet -VirtualNetwork $vnet -AddressPrefix $addressPrefix
$vnet | Set-AzVirtualNetwork