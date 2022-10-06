#Adding Citrix Module and set strict mode best practice to detect variable not declare
Add-PSSnapin Citrix.Broker.Admin.V2
Set-StrictMode -Version latest

#set variable to create shortcut. Replace "file-path" with the location of file. Example: "C:\temp\Server.csv"
$serverListPath= "C:\Temp\SHX Server List.csv"

#import server list from declared variable $serverListPath
$serverList= Import-Csv -Path $serverListPath -Delimiter ','

#export varible will use pipeline transfer output to csv
$export = [System.Collections.ArrayList]@()

#Headline
write-host "Servername `t Session `t Status "

foreach($server in $serverList)
{
    #Write-Host $server.ServerName to check if server attached right
    $connection=Test-Connection $server.ServerName -Count 1
    $sessionCount = Get-BrokerSession -MachineName ("*\" + $server.ServerName) | measure|select -ExpandProperty count
    $deliveryGroup = Get-BrokerSession -MachineName ("*\" + $server.ServerName) | select -ExpandProperty DesktopGroupName
    $serverName= $server.ServerName
   

    if($connection.StatusCode -eq 0){
       #output
        write-host  "$serverName `t`t $SessionCount `t $deliveryGroup `t online"
    
    }else{
         write-host  "$serverName `t`t $SessionCount `t $deliveryGroup `t offline"
    }

   #output to Array += to add into last line
   $export += [pscustomobject][ordered]@{
    ServerName = $server.ServerName
    Delivery_group = $deliveryGroup
    Session_Count = $sessionCount

   }
}

#change to outgrid view (ogv)
$export | ogv

#$export | Export-Csv -Path $serverListPath -Delimiter ',' -NoTypeInformation
