# CreateMasterScript.ps1

# Import required modules and check Azure PowerShell module
Import-Module -Name PowerShellGet
if (-not (Get-Module -ListAvailable -Name Az)) {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force
}

# Login to Azure
Connect-AzAccount

# Set the path where your scripts are stored
$scriptPath = "C:\PS_Source\MyAzure\MyAzure"
$results = @()

# Specify the resource group and location
$MyRGName = "rg-Mongo"
$Mylocation = "francecentral"

# Import required modules
Import-Module -Name Az.Network

# Function to capture results
Function Save-ResultData {
    param (
        [string]$Step,
        [bool]$Result
    )
    $global:results += @{ "Step" = $Step; "Result" = $Result }
}

# 1. Create Resource Group
$result = & "$scriptPath\1-Create-ResourceGroup.ps1" -ResourceGroupName $MyRGName -Location $Mylocation
Save-ResultData -Step "Create Resource Group" -Result $result

# 2. Create Virtual Network

$result = & "$scriptPath\2-Create-VirtualNetwork.ps1" -ResourceGroupName $MyRGName -Location $Mylocation -VNetName "MyVNet" -VNetAddressSpace "10.0.0.0/16" -SubnetName "MySubnet" -SubnetAddressPrefix "10.0.1.0/24"
Save-ResultData -Step "Create Virtual Network" -Result $result

# Create Public IP Address
$result = & "$scriptPath\3-Create-PublicIP.ps1" -ResourceGroupName $MyRGName -Location $Mylocation -PublicIPName "MyPublicIP"
Save-ResultData -Step "Create Public IP Address" -Result $result

# Create Network Security Group (NSG)
$result = & "$scriptPath\4-Create-NSG.ps1" -ResourceGroupName $MyRGName -Location $Mylocation -NSGName "MyNSG"
Save-ResultData -Step "Create NSG" -Result $result

# Create Network Interface
$publicIpId = (Get-AzPublicIpAddress -Name "MyPublicIP" -ResourceGroupName $MyRGName).Id
$nsgId = (Get-AzNetworkSecurityGroup -Name "MyNSG" -ResourceGroupName $MyRGName).Id
$subnetId = (Get-AzVirtualNetwork -Name "MyVNet" -ResourceGroupName $MyRGName).Subnets[0].Id
$result = & "$scriptPath\5-Create-NetworkInterface.ps1" -ResourceGroupName $MyRGName -Location $Mylocation -NICName "MyNIC" -SubnetId $subnetId -PublicIPId $publicIpId -NSGId $nsgId
Save-ResultData -Step "Create Network Interface" -Result $result

# Deploy VM
$result = & "$scriptPath\6-Create-VM.ps1" -ResourceGroupName $MyRGName -Location $Mylocation -VMName "MyVM" -VMSize "Standard_B1s" -NICName "MyNIC" -AdminUsername "adminUser" -AdminPassword "ComplexPassword123"
Save-ResultData -Step "Deploy VM" -Result $result

# Create Storage Account
$result = & "$scriptPath\7-Create-StorageAccount.ps1" -ResourceGroupName $MyRGName -Location $Mylocation -StorageAccountName "MyStorageAccount"
Save-ResultData -Step "Create Storage Account" -Result $result

# Determine overall success and generate deployment summary
$overallSuccess = !$results.Result.Contains($false)
$deploymentSummary = if($overallSuccess) {"Deployment succeeded"} else {"Deployment failed"}

# Output deployment summary to a file
$deploymentSummaryPath = "$scriptPath\deployment_summary.txt"
$deploymentSummary | Out-File -FilePath $deploymentSummaryPath
Write-Output "Deployment summary written to $deploymentSummaryPath"
# Capture results and save them
Save-ResultData -Step "Script Execution" -Result $true
