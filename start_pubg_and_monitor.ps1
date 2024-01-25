$gameProcessName = "TslGame"
$gameSteamId = "578080"
$alreadyRunning = $false
$extraProcessTerminated = $false

# OK, we need to first check if the game is already running
$gameProcess = Get-Process $gameProcessName -ErrorAction SilentlyContinue

# If the game is not running, we open via steam
if (-not $gameProcess) {
    Write-Host "Opening PUBG via steam."
    # This command will start PUBG via steam. Make sure you have steam running.
    Start-Process "steam://rungameid/$($gameSteamId)"
}

while (-not $extraProcessTerminated) {
    # Start monitoring
    Start-Sleep -Seconds 10

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
            exit
        }
    }
}

exit





while ($true) {
    # Start monitoring
    Start-Sleep -Seconds 10
    # Check if TslGame.exe is running
    $gameProcess = Get-Process $gameProcessName -ErrorAction SilentlyContinue
    if ($gameProcess -and -not $alreadyRunning) {
        # Run your script if the game has started and the script is not already running
        # Check if there are multiple TslGame processes running
        if ($gameProcess.Count -gt 1) {
            # Sort the processes by working set memory (memory usage) and select the one using the least memory
            $leastMemoryProcess = $gameProcess | Sort-Object WorkingSet -Descending | Select-Object -Last 1

            # Terminate the process using the least memory
            $leastMemoryProcess | Stop-Process
            Write-Host "Terminated TslGame.exe with ID $($leastMemoryProcess.Id) using the least memory."
            $extraProcessTerminated = $true
        } else {
            Write-Host "Only one or no TslGame.exe process found."
        }
    } elseif (-not $gameProcess) {
        # Reset the flag if the game is not running
        $alreadyRunning = $false
    }

    if ($extraProcessTerminated) {
        exit
    }

    # Wait for a bit before checking again
    Start-Sleep -Seconds 10
}
