# 7-Create-StorageAccount.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$MyRGName,

    [Parameter(Mandatory = $true)]
    [string]$Mylocation,

    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName
)

try {
    # Generating a unique name for the storage account
    $storageAccountName = $StorageAccountName.ToLower() -replace "[^a-z0-9]", ""

    # Create the storage account
    New-AzStorageAccount -ResourceGroupName $MyRGName -Name $storageAccountName -Location $Mylocation -SkuName "Standard_LRS" -Kind "StorageV2" -EnableHttpsTrafficOnly $true
    Write-Output "Storage Account '$storageAccountName' created in '$Mylocation'."
    return $true
} catch {
    Write-Error "Error encountered during Storage Account creation: $_"
    return $false
}
