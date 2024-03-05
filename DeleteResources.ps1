# DeleteResources.ps1

# Set your Azure Resource Group Name
$ResourceGroupName = "MyResourceGroup"

# Optionally, confirm before deletion
$confirmation = Read-Host "Are you sure you want to delete all resources in the resource group $ResourceGroupName? (yes/no)"
if ($confirmation -ne 'yes') {
    Write-Host "Deletion cancelled."
    exit
}

# Login to Azure
Write-Host "Connecting to Azure..."
Connect-AzAccount

# Delete the VM first to ensure no dependencies block the deletion
Write-Host "Deleting VM..."
Remove-AzVM -ResourceGroupName $ResourceGroupName -Name "MyVM" -Force

# Delete the Network Interface
Write-Host "Deleting Network Interface..."
Remove-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name "MyNIC" -Force

# Delete the Network Security Group
Write-Host "Deleting Network Security Group..."
Remove-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name "MyNSG" -Force

# Delete the Public IP Address
Write-Host "Deleting Public IP Address..."
Remove-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name "MyPublicIP" -Force

# Delete the Virtual Network
Write-Host "Deleting Virtual Network..."
Remove-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name "MyVNet" -Force

# Delete the Storage Account
Write-Host "Deleting Storage Account..."
Remove-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name "MyStorageAccount" -Force

# Finally, delete the Resource Group itself
Write-Host "Deleting Resource Group..."
Remove-AzResourceGroup -Name $ResourceGroupName -Force

Write-Host "All specified resources and the resource group have been deleted."
