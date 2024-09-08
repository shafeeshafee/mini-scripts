#!/bin/bash

# Purpose: a script that loops through a list of software packages and checks their current version on the system, and prints it. (Ubuntu/Debian based systems)

# Notes:

# command is a way to get to the true system command, so it bypasses any other created commands with the same name.

# dpkg-query (debian/ubuntu only). This command lets you query the package database. It's as if you're asking the system about what's installed in it.
# dpkg-query flags:
# - W tells dpkg-query to show info about packages
# -f='${Version}' specifies the output format. In this case we're just asking for the version #
# dpkg -l checks if a package is installed

packages_to_check=("systemd" "htop" "python3" "git" "curl" "nmap" "apt")

# get package version
get_version() {
    dpkg-query -W -f='${Version}' "$1" 2>/dev/null
}

# loop through packages
for package in "${packages_to_check[@]}"; do
    echo "Currently checking $package. Hang tight!"

    # &> redirects both stdout and stderr to the black hole
    if dpkg -l "$package" &> /dev/null; then
        version=$(get_version "$package")
        echo "$package (v$version) is currently installed on your system."
    else
        echo "$package isn't installed."
        read -p "Would you like to install it? (yes/no): " user_answer

        if [[ "$answer" == "yes" ]]; then
            echo "Okay! Installing $package..."
            sudo apt update
            sudo apt install -y "$package"
            
            # $? is referring to the last command. As in, was it installed successfully (exit code 0)?
            if [ $? -eq 0 ]; then
                version=$(get_version "$package")
                echo "$package was installed successfully."
            else
                echo "An unexpected error happened, sorry!"
            fi
        else 
            echo "Okay, skipping installing $package."
        fi
    fi
    echo " ------------------ "
done