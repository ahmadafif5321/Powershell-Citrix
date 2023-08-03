Add-PSSnapin Citrix*
Set-StrictMode -version latest

#Replace the "filepath" with the location of file
$Path = "filepath"
$VDIList = Get-Content -Path $Path

$export = [System.Collections.ArrayList]@()

foreach ($VDI in $VDIList) {
    $brokerMachine = Get-BrokerMachine -MachineName $VDI
    $output = "User assigned for $VDI : $($brokerMachine.AssociatedUserFullNames)"
    Write-Host $output
    $export.Add($output) | Out-Null
}

$export | Out-GridView -Title "VDI USer assign" -OutputMode Multiple