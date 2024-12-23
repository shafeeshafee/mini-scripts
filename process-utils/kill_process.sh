#!/bin/bash
#
# kill_process.sh
# ---------------
# Purpose:
#   Lists running processes, prompts for a PID, attempts to kill it.
#
# Usage:
#   ./kill_process.sh
#
# Notes:
#   - This script prints all processes in short format (PID, Command).
#   - Use carefully; killing essential processes can crash the system.

echo "Currently running processes (PID CMD):"
# Display PID and CMD
ps -e -o pid,cmd

read -p "Enter the PID of the process to kill: " PID_CHOICE

# Validate numeric input
if [[ "$PID_CHOICE" =~ ^[0-9]+$ ]]; then
  if ps -p "$PID_CHOICE" &>/dev/null; then
    kill "$PID_CHOICE"
    if [ $? -eq 0 ]; then
      echo "Process $PID_CHOICE terminated."
    else
      echo "Failed to kill $PID_CHOICE. Check permissions or try again."
    fi
  else
    echo "No active process with PID $PID_CHOICE."
  fi
else
  echo "Invalid PID. Must be numeric."
fi
