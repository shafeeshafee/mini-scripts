#!/bin/bash

# File to analyze
log_file="web-server-access-logs.log"

# Check if the file exists
if [ ! -f "$log_file" ]; then
    echo "Error: $log_file not found!"
    exit 1
fi

# Use awk to filter 404 errors, extract IP addresses, and count occurrences
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
' "$log_file" | sort -rnk2