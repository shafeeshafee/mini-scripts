#!/bin/bash

# Purpose: continuously monitors CPU usage. If the CPU usage exceeds a certain threshold (e.g., 70%), logs the event to a file.

# (( )) in bash is used for arithmetic
# the `-bn1` flag runs top in batch mode once. It's like taking a single snapshot of top's data and printing it.
# in awk, the $n between {} represent the column numbers
# `bc` is basic calculator. `l` handles floating point arithmetic, otheriwse it would just handle integers


echo "Starting monitor tool... Hang on tight..."

# threshold that if exceeded, writes to log
threshold=75

# get total cpu usage

# while the script is running
while true; do
    # extracts both $2 user cpu usage (apps, programs, etc.) and $4 system usage (kernel tasks, required services, etc.)
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    # if cpu usage is over threshold, send them to bash jail
    if (( $(echo "$cpu_usage > $threshold" | bc -l ) )); then
        exceeded_by=$(echo "$cpu_usage - $threshold" | bc -l)
       
        echo -e "High CPU usage detected: $cpu_usage%\n"
        echo "Logging this event to '$log_file' ..."

        if [ ! -e "usage-log.txt" ]; then
            echo "No log file detected. Creating one now."
        fi

        echo "[$(date +"%Y-%m-%d %H:%M:%S")] CPU usage exceeded threshold $exceeded_by% : $cpu_usage%" >> "$log_file"

    else
        echo "CPU usage is normal."
    fi

    # do this check every 5 seconds
    sleep 5
done

