# 5-Create-NetworkInterface.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$NICName,

    [Parameter(Mandatory = $true)]
    [string]$SubnetId,

    [Parameter(Mandatory = $true)]
    [string]$PublicIPId,

    [Parameter(Mandatory = $true)]
    [string]$NSGId
)

try {
    $nic = New-AzNetworkInterface -Name $NICName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $SubnetId -PublicIpAddressId $PublicIPId -NetworkSecurityGroupId $NSGId
    Write-Output "Network Interface '$NICName' created in '$Location'."
    return $true
} catch {
    Write-Error "Error creating Network Interface: $_"
    return $false
}
