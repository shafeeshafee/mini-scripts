#!/bin/bash

# Get's path from user input
path="$1"

install_gh() {
    echo "Installing GitHub CLI..."
    # sudo apt-get update
    # sudo apt-get install -y gh
    brew install gh
    echo "GitHub CLI installed successfully!"
    echo "Please authenticate your GitHub account:"
    echo "Running 'gh auth login'..."

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
            # todo: cli app for each OS type (macOS, Linux, Windows)
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
