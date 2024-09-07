#!/bin/bash

# Purpose: lists all running processes and allows the user to kill a process by entering its PID.

echo "Hello. Here are all the processes that are running..."

ps -e -o pid,comecho -e "\n"

# Prompt the user and store the input in user_choice
read -p "Please select a process you want to end (by PID): " user_choice

# the regex here checks if its numerical
# =~ is used for regex matching  inside [[ ... ]]
if [[ "$user_choice" =~ ^[0-9]+$ ]]; then
    # Check if the process with the entered PID exists
    if ps -p "$user_choice" > /dev/null 2>&1; then
        # Try to kill the process
        kill "$user_choice"

        # Check if the kill command was successful
        if [ $? -eq 0 ]; then
            echo "Process $user_choice has been terminated."
        else
            echo "Failed to kill $user_choice. Do you have permissions? Try again soon."
        fi
    else
        echo "No active process found with PID $user_choice."
    fi
else
    echo "Invalid PID. Enter a valid *numerical* PID, please!"
fi