# 5-Create-NetworkInterface.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$MyRGName,

    [Parameter(Mandatory = $true)]
    [string]$Mylocation,

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
    $nic = New-AzNetworkInterface -Name $NICName -ResourceGroupName $MyRGName -Location $Mylocation -SubnetId $SubnetId -PublicIpAddressId $PublicIPId -NetworkSecurityGroupId $NSGId
    Write-Output "Network Interface '$NICName' created in '$Mylocation'."
    return $true
} catch {
    Write-Error "Error creating Network Interface: $_"
    return $false
}
