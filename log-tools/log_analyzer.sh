#!/bin/bash
#
# log_analyzer.sh
# ---------------
# Purpose:
#   Scans /var/log/auth_log.log for suspicious keywords ("failed",
#   "unauthorized", "error"), and appends those lines to suspicious_activity.log.
#
# Usage:
#   ./log_analyzer.sh
#
# Notes:
#   - Adjust 'LOG_SOURCE' as needed. By default looks for /var/log/auth_log.log.

LOG_SOURCE="/var/log/auth_log.log"
OUTPUT="suspicious_activity.log"
KEYWORDS=("failed" "unauthorized" "error")

if [ ! -f "$LOG_SOURCE" ]; then
  echo "Error: '$LOG_SOURCE' not found."
  exit 1
fi

# Create output if not present
[ ! -f "$OUTPUT" ] && touch "$OUTPUT"

while IFS= read -r line; do
  lower_line=$(echo "$line" | tr '[:upper:]' '[:lower:]')
  for kw in "${KEYWORDS[@]}"; do
    if [[ "$lower_line" == *"$kw"* ]]; then
      echo "$line" >> "$OUTPUT"
      break
    fi
  done
done < "$LOG_SOURCE"

echo "Done analyzing. Check '$OUTPUT' for suspicious entries."
