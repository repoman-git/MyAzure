# 2-Create-VirtualNetwork.ps1
param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Location,

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
    $vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location -Name $VNetName -AddressPrefix $VNetAddressSpace
    Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressPrefix -VirtualNetwork $vnet | Set-AzVirtualNetwork
    Write-Output "Virtual Network '$VNetName' with Subnet '$SubnetName' created in '$Location'."
    return $true
} catch {
    Write-Error "Error creating Virtual Network: $_"
    return $false
}
