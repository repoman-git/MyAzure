#1-create-resourcegroup.ps1

param (
    [Parameter(Mandatory=$true)]
    [string]$MyRGName = "$MyRGName"

    [Parameter(Mandatory=$true)]
    [string]$Mylocation = "$Mylocation"
)

try {
    New-AzResourceGroup -Name $MyRGName -Location $Mylocation
    Write-Output "Resource Group '$MyRGName' created in '$Mylocation'."
    return $true
} catch {
    Write-Error "Error creating Resource Group: $_"
    return $false
}
