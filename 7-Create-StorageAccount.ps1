# 7-Create-StorageAccount.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName
)

try {
    # Generating a unique name for the storage account
    $storageAccountName = $StorageAccountName.ToLower() -replace "[^a-z0-9]", ""

    # Create the storage account
    New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $storageAccountName -Location $Location -SkuName "Standard_LRS" -Kind "StorageV2" -EnableHttpsTrafficOnly $true
    Write-Output "Storage Account '$storageAccountName' created in '$Location'."
    return $true
} catch {
    Write-Error "Error encountered during Storage Account creation: $_"
    return $false
}
