# Wait for 30 seconds after the script starts
Start-Sleep -Seconds 10

# Get all processes named 'TslGame'
$processes = Get-Process TslGame -ErrorAction SilentlyContinue

# Check if there are multiple TslGame processes running
if ($processes.Count -gt 1) {
    # Sort the processes by working set memory (memory usage) and select the one using the least memory
    $leastMemoryProcess = $processes | Sort-Object WorkingSet -Descending | Select-Object -Last 1

    # Terminate the process using the least memory
    $leastMemoryProcess | Stop-Process
    Write-Host "Terminated TslGame.exe with ID $($leastMemoryProcess.Id) using the least memory."
} else {
    Write-Host "Only one or no TslGame.exe process found."
}
