$powershellApplicationName = "Start PUBG and Monitor Application"
$gameProcessName = "TslGame"
$gameSteamId = "578080"
$extraProcessTerminated = $false
$secondsToAwait = 10


Write-Host "Initialising $($powershellApplicationName)"

# OK, we need to first check if the game is already running
$gameProcess = Get-Process $gameProcessName -ErrorAction SilentlyContinue

# If the game is not running, we open via steam
if (-not $gameProcess) {
    Write-Host "Opening PUBG via steam."
    # This command will start PUBG via steam. Make sure you have steam running.
    Start-Process "steam://rungameid/$($gameSteamId)"
}
else {
    Write-Host "PUBG is already running."
}

while (-not $extraProcessTerminated) {
    Write-Host "Waiting for $($secondsToAwait) seconds to start search..."
    # Start monitoring
    Start-Sleep -Seconds $secondsToAwait

    Write-Host "Searching for $($gameProcessName) processes."
    $gameProcess = Get-Process $gameProcessName -ErrorAction SilentlyContinue

    if ($gameProcess) {
        Write-Host "$($gameProcess.Count) processes found."
        # Run your script if the game has started and the script is not already running
        # Check if there are multiple TslGame processes running
        if ($gameProcess.Count -gt 1) {
            # Sort the processes by working set memory (memory usage) and select the one using the least memory
            $leastMemoryProcess = $gameProcess | Sort-Object WorkingSet -Descending | Select-Object -Last 1

            # Terminate the process using the least memory
            $leastMemoryProcess | Stop-Process -Force
            Write-Host "Terminated $($gameProcessName) with ID $($leastMemoryProcess.Id) using the least memory."
            $extraProcessTerminated = $true
        } else {
            Write-Host "Only one or no $($gameProcessName) process found."
            Write-Host "Closing $($powershellApplicationName) in $($secondsToAwait) seconds..."
            # Start monitoring
            Start-Sleep -Seconds $secondsToAwait
            exit
        }
    }
}

exit