#1-create-resourcegroup.ps1

param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Location
)

try {
    New-AzResourceGroup -Name $ResourceGroupName -Location $Location
    Write-Output "Resource Group '$ResourceGroupName' created in '$Location'."
    return $true
} catch {
    Write-Error "Error creating Resource Group: $_"
    return $false
}
