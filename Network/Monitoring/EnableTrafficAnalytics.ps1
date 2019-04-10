#Connect to Azure 
Connect-AzAccount
Get-AzSubscription -SubscriptionName "" | set-azcontext 
Get-AzSubscription -SubscriptionName "" | set-azcontext 

#Resource Provider Registration 
Register-AzResourceProvider -ProviderNamespace "Microsoft.Network"
Register-AzResourceProvider -ProviderNamespace Microsoft.Insights

#variables
$stgrgname = ""
$logaworkspacename = ""
$logarg = ""
$storageID = ""
$nsgname = ""
$nsgrgname = ""
$workspace = Get-AzOperationalInsightsWorkspace -Name $logaworkspacename -ResourceGroupName $logarg

#Create a new storage account if it doesnt exist - one account per region is sufficient 
New-AzStorageAccount -Location "australiaeast" -Name "" -ResourceGroupName $stgrgname -SkuName Standard_LRS -Kind StorageV2

#set NSG and NetworkWatcher information
$NW = Get-AzNetworkWatcher   -ResourceGroupName NetworkWatcherRg -Name NetworkWatcher_australiaeast
$nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $nsgrgname -Name $nsgname

#set Flowlog configuration 
Set-AzNetworkWatcherConfigFlowLog -FormatVersion 2 -FormatType Json -NetworkWatcher $NW -TargetResourceId $nsg.Id -EnableFlowLog $true -StorageAccountId $storageID -EnableTrafficAnalytics -Workspace $workspace -RetentionInDays 30 

#apply to multiple NSGs 
$Listofnsgs = Get-AzNetworkSecurityGroup
ForEach ($nsgname in $listofnsgs) {
    try {
        Write-Output "Starting to process nsg = $nsgname" 
        Set-AzNetworkWatcherConfigFlowLog -FormatVersion 2 -FormatType Json -NetworkWatcher $NW -TargetResourceId $nsg.Id -EnableFlowLog $true -StorageAccountId $storageID -EnableTrafficAnalytics -Workspace $workspace -RetentionInDays 30 
    } Catch {
        $errorDetails = $_.Exception.Message
        $ErrorMessages += "Error: $errorDetails `n"
    }
    
    }

