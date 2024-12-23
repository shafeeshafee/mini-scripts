#!/bin/bash
#
# 404_log_filter.sh
# -----------------
# Purpose:
#   Analyzes a web server access log file for 404 errors, counting how many
#   times each IP caused a 404. Sorts by highest frequency.
#
# Usage:
#   ./404_log_filter.sh
#
# Notes:
#   - Default log file is 'web-server-access-logs.log' in the same folder.
#   - Adjust 'LOG_FILE' as needed.

LOG_FILE="web-server-access-logs.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Error: log file '$LOG_FILE' not found!"
  exit 1
fi

awk '
  $9 == "404" {
    ip = $1
    count[ip]++
  }
  END {
    for (ip in count) {
      print ip, count[ip]
    }
  }
' "$LOG_FILE" | sort -rnk2
