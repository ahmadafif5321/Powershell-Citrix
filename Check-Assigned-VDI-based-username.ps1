Add-PSSnapin Citrix*
Set-StrictMode -Version latest

#Replace the "filepath" with the location of file
$VDIuser = Get-Content -Path "path"

$output = foreach($user in $VDIuser)
{
    $username = Get-BrokerDesktop | Where-Object { $_.AssociatedUserFullNames -eq $user }
    $output = "VDI Assigned for $user : $($username.MachineName)"
    Write-Output $output
}

$output | Ogv