#4-Create-NSG.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$NSGName
)

try {
    $nsgRuleRdp = New-AzNetworkSecurityRuleConfig -Name "RDP-Allow" -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix Internet -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange 3389 -Access Allow
    $nsg = New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $ResourceGroupName -Location $Location -SecurityRules $nsgRuleRdp
    Write-Output "Network Security Group '$NSGName' created in '$Location'."
    return $true
} catch {
    Write-Error "Error creating Network Security Group: $_"
    return $false
}
