# List of Citrix servers
$servers = @( "servername")

# Define the correct Citrix Desktop Service name (BrokerAgent)
$citrixService = "BrokerAgent"

# Prompt for credentials once
$credential = Get-Credential

# Loop through each server and restart the service
foreach ($server in $servers) {
    Write-Host "Restarting Citrix BrokerAgent Service on $server..." -ForegroundColor Green
    
    try {
        # Restart BrokerAgent Service remotely using the stored credentials
        Invoke-Command -ComputerName $server -Credential $credential -ScriptBlock {
            Restart-Service -Name "BrokerAgent" -Force
            Write-Host "BrokerAgent Service Restarted on $env:COMPUTERNAME"
        }
    }
    catch {
        Write-Host "Failed to restart service on $server $_" -ForegroundColor Red
    }
}
