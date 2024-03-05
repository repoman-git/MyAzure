# 6-Create-VM.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$VMName,

    [Parameter(Mandatory = $true)]
    [string]$VMSize,

    [Parameter(Mandatory = $true)]
    [string]$NICId,

    [Parameter(Mandatory = $true)]
    [string]$AdminUsername,

    [Parameter(Mandatory = $true)]
    [SecureString]$AdminPassword,

    [string]$ImagePublisher = "MicrosoftWindowsServer",
    [string]$ImageOffer = "WindowsServer",
    [string]$ImageSku = "2019-Datacenter",
    [string]$Version = "latest"
)

try {
    $securePassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($AdminUsername, $securePassword)

    $vmConfig = New-AzVMConfig -VMName $VMName -VMSize $VMSize |
                Set-AzVMOperatingSystem -Windows -ComputerName $VMName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate |
                Set-AzVMSourceImage -PublisherName $ImagePublisher -Offer $ImageOffer -Skus $ImageSku -Version $Version |
                Add-AzVMNetworkInterface -Id $NICId |
                Set-AzVMOSDisk -Name "$VMName-osdisk" -CreateOption FromImage -StorageAccountType "Standard_LRS"

    New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vmConfig -Verbose
    Write-Output "VM '$VMName' successfully created in '$Location'."
    return $true
} catch {
    Write-Error "Error encountered during VM creation: $_"
    return $false
}
