# 2-Create-VirtualNetwork.ps1
param (
    [Parameter(Mandatory=$true)]
    [string]$MyRGName,

    [Parameter(Mandatory=$true)]
    [string]$Mylocation,

    [Parameter(Mandatory=$true)]
    [string]$VNetName,

    [Parameter(Mandatory=$true)]
    [string]$VNetAddressSpace,

    [Parameter(Mandatory=$true)]
    [string]$SubnetName,

    [Parameter(Mandatory=$true)]
    [string]$SubnetAddressPrefix
)

try {
    $vnet = New-AzVirtualNetwork -ResourceGroupName $MyRGName -Location $Mylocation -Name $VNetName -AddressPrefix $VNetAddressSpace
    Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressPrefix -VirtualNetwork $vnet | Set-AzVirtualNetwork
    Write-Output "Virtual Network '$VNetName' with Subnet '$SubnetName' created in '$Mylocation'."
    return $true
} catch {
    Write-Error "Error creating Virtual Network: $_"
    return $false
}
