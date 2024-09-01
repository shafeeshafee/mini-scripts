#!/bin/bash

echo "Welcome. Let's check if a filename exists."
read -p "Please enter a filename: " user_input

initial_file_size_kb=$(du -k "$user_input" | cut -f 1)
file_size_mb=$((initial_file_size_kb / 1000))

if [[ -f "$user_input" ]]; then
    echo "File exists, its size is $file_size_mb megabytes."
else
    echo "doesn't exist"
fi