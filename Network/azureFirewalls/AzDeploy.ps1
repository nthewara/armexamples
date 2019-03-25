Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] [Parameter(Mandatory=$true)] $vnetname
)

#Variables
$Randomstring = -join ((97..122) | Get-Random -Count 8 | % {[char]$_})

##function
function ConvertTo-HashtableFromPsCustomObject { 
     param ( 
     [Parameter( 
     Position = 0, 
     Mandatory = $true, 
     ValueFromPipeline = $true, 
     ValueFromPipelineByPropertyName = $true 
     )] [object[]]$psCustomObject 
     ); 
    
     process { 
     foreach ($myPsObject in $psCustomObject) { 
     $output = @{}; 
     $myPsObject | Get-Member -MemberType NoteProperty | % { 
     $output.($_.name) = $myPsObject.($_.name); 
     } 
    
     return $output; 
     } 
     } 
    } 

$templateFilePath = "https://raw.githubusercontent.com/nthewara/armexamples/master/Network/azureFirewalls/firewall.json"
$paramUri = "https://raw.githubusercontent.com/nthewara/armexamples/master/Network/azureFirewalls/parameters.firewall.json"


$ParamRequest = invoke-webrequest -Uri $paramUri
$paramfile = $ParamRequest.content | ConvertFrom-Json
$paramfile.parameters.virtualNetworkName = $vnetname
$paramfile.parameters.azureFirewallName = "azfw-"+$Randomstring 
$paramfile.parameters.publicIpAddressName = $paramfile.parameters.azureFirewallName +"-pip01"

$params = $paramfile.parameters
$htParams = ConvertTo-HashtableFromPsCustomObject $params
$htParams

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateFilePath -TemplateParameterObject $htParams 

#Validate
#Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateFilePath -azureFirewallName $azfirewallname -virtualNetworkName $vnetname -publicipaddressname $publicIpAddressName

#deploy
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateFilePath -azureFirewallName $azfirewallname -virtualNetworkName $vnetname -publicipaddressname $publicIpAddressName

