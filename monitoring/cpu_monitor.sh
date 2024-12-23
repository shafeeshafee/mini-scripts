#!/bin/bash
#
# cpu_monitor.sh
# --------------
# Purpose:
#   Continuously monitors CPU usage. If usage exceeds a threshold (75% by default),
#   logs the event to 'usage-log.txt'.
#
# Usage:
#   ./cpu_monitor.sh
#
# Notes:
#   - Runs in a loop every 5s. Press Ctrl+C to stop.

THRESHOLD=75
LOG_FILE="usage-log.txt"

echo "Starting CPU monitor (threshold = ${THRESHOLD}%). Press Ctrl+C to stop."

while true; do
  # Grab user + system usage from 'top'
  CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

  # Compare usage to threshold using 'bc' for float arithmetic
  if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    TIME_STAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${TIME_STAMP}] High CPU usage: ${CPU_USAGE}% (threshold: ${THRESHOLD}%)" >> "$LOG_FILE"
    echo "High CPU usage! Logged to '$LOG_FILE'."
  else
    echo "CPU usage is normal: ${CPU_USAGE}%"
  fi

  sleep 5
done
