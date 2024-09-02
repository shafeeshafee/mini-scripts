#!/bin/bash

# Purpose: check if a process is running or not

process_name=$1

# --quiet makes sure nothing is printed to the terminal
if systemctl is-active --quiet $process_name; then
    status="running"
else
    status="not running"
fi

echo "Process $process_name is $status."