#!/bin/bash

# Purpose: Checks if a file exists, gives file size.

echo "Welcome. Let's check if a filename exists."

filename=$1

if [[ -f "$filename" ]]; then
    file_size=$(du -k "$filename" | cut -f 1)
    
    if [ $file_size -gt 999 ]; then
        file_size_in_mb=$(echo "scale=1; $file_size / 1000" | bc)
        echo "File size is ${file_size_in_mb} megabytes."
    elif [ $file_size -lt 1000 ]; then
        echo  "File size is $file_size kilobytes."
    fi

else
    echo "File does not exist."
fi