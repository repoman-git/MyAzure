# 3- Create-PublicIP.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$MyRGName,

    [Parameter(Mandatory = $true)]
    [string]$Mylocation,

    [Parameter(Mandatory = $true)]
    [string]$PublicIPName
)

try {
    $publicIp = New-AzPublicIpAddress -Name $PublicIPName -ResourceGroupName $MyRGName -Location $Mylocation -AllocationMethod Dynamic
    Write-Output "Public IP Address '$PublicIPName' created in '$Mylocation'."
    return $true
} catch {
    Write-Error "Error creating Public IP Address: $_"
    return $false
}
