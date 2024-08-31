#!/bin/bash

# Purpose: Detects new files in a directory, installs GitHub CLI if necessary, pushes changes to GitHub, and prompts to create a repository if it doesn't exist.

# Get's path from user input
path="$1"

gh_install_based_on_OS() {
    os_name=$(uname -s) 

    case "$os_name" in
        # MacOS
        "Darwin")
            echo "OS: macOS"
            echo "Installing gh with brew" 
            brew install gh
            ;;
        # Windows
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            echo "OS: Windows"
            # Check if winget is installed
            if command -v winget &> /dev/null; then
                echo "Installing gh with winget"
                winget install --id GitHub.cli
            else
                echo "winget not found. Please install winget or install GitHub CLI manually."
                exit 1
            fi
            ;;
        "Linux")
            # Detect which Linux distribution and install gh
            . /etc/os-release 2>/dev/null || { echo "Unknown Linux distribution"; exit 1; }
            case $ID in
                ubuntu|debian)
                    echo "OS: Ubuntu/Debian"
                    echo "Installing gh with apt"
                    sudo apt update
                    sudo apt install -y gh
                    gh --version
                    ;;
                arch)
                    echo "OS: Arch Linux"
                    echo "Installing gh with pacman"
                    sudo pacman -Syu
                    sudo pacman -S --noconfirm github-cli
                    gh --version
                    ;;
                *)
                    echo "Unsupported Linux distribution: $ID"
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Unknown or unsupported operating system: $os_name"
            exit 1
            ;;
    esac
}

install_gh() {
    echo "Installing GitHub CLI..." 
    gh_install_based_on_OS
    echo "GitHub CLI installed successfully!"
    echo "Please authenticate your GitHub account:"
    echo "Running 'gh auth login'. Please go through each of the steps to login to your GitHub ..."

    gh auth login

    if [[ $? -eq 0 ]]; then
        echo "Authentication successful!"
    else
        echo "Authentication failed. Please run 'gh auth login' manually."
    fi
}

# check if path exists
if [[ -d "$path" ]]; then
    # Navigate to that path
    cd "$path" || { echo "Path $path doesn't exist."; exit 1; }

    if $(gh --version > /dev/null 2>&1); then
        echo "gh cli installed"
    else
        read -p "GitHub CLI not installed. Install gh cli? (yes/no): " install_cli_decision
        if [[ $install_cli_decision == "yes" ]]; then
            install_gh
        else
            echo -e "You will have to install GitHub CLI to create new repos and push changes to them.\n"
        fi
    fi

    # Gets URL of the current working directory's remote GitHub repo
    if git config --get remote.origin.url; then
        echo "Entered repo: GitHub repo $(git config --get remote.origin.url)"
    # If there is no GitHub remote, assume this repo needs to be created.
    else
        echo "There isn't a remote GitHub URL for this directory"

        if $(gh --version > /dev/null 2>&1); then
            echo "gh cli installed"
        else
            read -p "GitHub CLI not installed. Install gh cli? (yes/no): " install_cli_decision
            if [[ $install_cli_decision == "yes" ]]; then
                # todo: cli app for each OS type (macOS, Linux, Windows)
                install_gh
            else
                echo -e "You will have to install GitHub CLI to create new repos and push changes to them.\n"
            fi
        fi
    fi

    # Uses Git's `ls-files` command to list files in the repository.
    # The --others option includes untracked files, which are not part of the repository
    # The --exclude-standard option excludes files from .gitignore
    untracked_files=$(git ls-files --others --exclude-standard)

    if [[ -n "$untracked_files" ]]; then
        echo "Untracked files detected:"
        echo "$untracked_files"
        
        read -p "Commit and push to GitHub? (yes/no) " push_to_gh_decision
        
        if [[ "$push_to_gh_decision" == "yes" ]]; then
            echo -e "Starting push to GitHub now...\n"
            git add .
            git commit -m "Add untracked file(s)"
            git push origin main
        else
            echo -e "You chose not to push. Exiting...\n"
            exit 0
        fi
    else
        echo "No new files. Clear!"
    fi
else
    echo "Path doesn't exist."
fi
