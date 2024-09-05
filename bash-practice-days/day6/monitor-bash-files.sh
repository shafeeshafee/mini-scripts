#!/bin/bash

# Purpose: find all bash (.sh) files in system, make them executable.
# Disclaimer: This is only for educational purposes, and not safe to do.

# find searches bash files in command substitution. Find only in /home/ubuntu
# for loop will go through each bash item found in `find`'s result

for file in $(find /home/ubuntu/ -name "*.sh" -type f 2>dev>null); do
    # if the file already has execution rights, we don't do anything. But if it doesn't, notify the user, then chmod +x it.
    if [ ! -x "$file" ]; then
        echo -e "Found bash file that needs x rights...\n"
        chmod +x "$file"
        echo -e "\nMade $file executable!"
    fi
done        
        




