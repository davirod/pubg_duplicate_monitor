# README.md for Starting PUBG via Steam and killing extra processes

## Overview
This script is designed to manage the execution of the game "PlayerUnknown's Battlegrounds" (PUBG), identified by the Steam ID "578080". The primary function is to ensure that the game is launched and running optimally by monitoring and managing multiple instances of the game process.

## Requirements
- Windows operating system
- PowerShell
- Steam client installed
- PUBG installed in the Steam library

## How It Works
1. **Initial Check**: The script first checks if PUBG is already running on the system.
2. **Game Launch**: If PUBG is not running, the script will launch it through Steam.
3. **Process Monitoring and Management**: The script continuously monitors the system for multiple instances of the PUBG process. If more than one instance is found, it terminates the one using the least memory to optimize performance.

## Usage Guide

### Running the Script
1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Run the script using the command `.\[script name].ps1`.

### Script Details
- `$gameProcessName`: The name of the PUBG process to monitor, set to `"TslGame"`.
- `$gameSteamId`: The Steam ID of PUBG, set to `"578080"`.
- `$extraProcessTerminated`: A flag to indicate if an extra game process has been terminated, initially set to `$false`.

### Launching PUBG
- If PUBG is not running, the script outputs "Opening PUBG via steam." and launches the game through the Steam URL protocol.

### Process Monitoring
- The script enters a loop, where every 10 seconds, it checks for the PUBG process.
- If multiple instances of the game are found, it sorts these by memory usage and terminates the one using the least memory.
- A message is displayed indicating the termination of the process, including its ID.

### Exiting the Script
- If only one or no instances of the game process are found, the script displays a corresponding message and exits.

## Important Notes
- Ensure Steam is running before executing the script.
- This script requires administrative privileges to terminate processes.
- Use this script responsibly, considering it can terminate processes on your system.

## Disclaimer
This script is provided "as is", and the author is not responsible for any unintended consequences that may arise from its use. Users should understand the script's functionality and agree to use it at their own risk.