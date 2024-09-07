#!/bin/bash

# Purpose: A script that reads usernames from a file, checks if they exist, prints their home directory and shell, and if not, creates them and prints the same.

# Notes:
# getent is a command that looks up info from system databases, like users, groups, hostnames on the computer. When you're using `getent passwd username` it's like asking "Hey you there! Yes you... What information do we have on this user, eh?"

txt_to_array() {
    user_input=$1

    # Check if the file exists
    if [ ! -e "$user_input" ]; then
        echo "There is no file with that name. Check spelling, or try again."
        exit 1
    else
        echo "Reading usernames from '$user_input'..."
    fi

    # read file line by line
    while IFS= read -r username; do
        # check if user exists in /etc/passwd
        if getent passwd "$username" > /dev/null; then
            echo "Checking user '$username'..."
            echo "User '$username' exists."
            home_dir=$(getent passwd "$username" | cut -d: -f6)
            shell=$(getent passwd "$username" | cut -d: -f7)
            echo "Home directory: $home_dir"
            echo "Shell: $shell"
        else
            echo "Checking user '$username'..."
            echo "User '$username' doesn't exist."
            echo "Creating user '$username'..."
            sudo useradd -m "$username"

            # $? is a special var that holds exit status of last command executed.
            # 0 if successful, <0 if failed
            if [ $? -eq 0 ]; then
                # gets home dir for new user
                home_dir=$(getent passwd "$username" | cut -d: -f6)
                shell=$(getent passwd "$username" | cut -d: -f7)
                echo "User '$username' created."
                echo "Home directory: $home_dir"
                echo "Shell: $shell"
            else
                echo "Failed to create user '$username'."
            fi
        fi
    done < "$user_input"
}

