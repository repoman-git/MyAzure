# 3- Create-PublicIP.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$PublicIPName
)

try {
    $publicIp = New-AzPublicIpAddress -Name $PublicIPName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Dynamic
    Write-Output "Public IP Address '$PublicIPName' created in '$Location'."
    return $true
} catch {
    Write-Error "Error creating Public IP Address: $_"
    return $false
}
