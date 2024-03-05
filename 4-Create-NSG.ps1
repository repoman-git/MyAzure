#4-Create-NSG.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$MyRGName,

    [Parameter(Mandatory = $true)]
    [string]$Mylocation,

    [Parameter(Mandatory = $true)]
    [string]$NSGName
)

try {
    $nsgRuleRdp = New-AzNetworkSecurityRuleConfig -Name "RDP-Allow" -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix Internet -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange 3389 -Access Allow
    $nsg = New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $MyRGName -Location $Mylocation -SecurityRules $nsgRuleRdp
    Write-Output "Network Security Group '$NSGName' created in '$Mylocation'."
    return $true
} catch {
    Write-Error "Error creating Network Security Group: $_"
    return $false
}
