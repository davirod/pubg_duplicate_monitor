$gameProcessName = "TslGame"
$scriptToRun = "pubg_close_extra_tslgame.ps1"
$alreadyRunning = $false

while ($true) {
    # Check if TslGame.exe is running
    $gameProcess = Get-Process $gameProcessName -ErrorAction SilentlyContinue
    if ($gameProcess -and -not $alreadyRunning) {
        # Run your script if the game has started and the script is not already running
        Start-Process "PowerShell.exe" -ArgumentList "-File $scriptToRun" -Verb RunAs
        $alreadyRunning = $true
    } elseif (-not $gameProcess) {
        # Reset the flag if the game is not running
        $alreadyRunning = $false
    }

    # Wait for a bit before checking again
    Start-Sleep -Seconds 10
}
