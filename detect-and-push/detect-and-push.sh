#!/bin/bash

# Get's path from user input
path="$1"

# check if path exists
if [[ -d "$path" ]]; then
    # Navigate to that path
    cd "$path" || { echo "Path $path doesn't exist."; exit 1; }

    # Uses Git's `ls-files` command to list files in the repository.
    # The --others option includes untracked files, which are not part of the repository.
    # The --exclude-standard option excludes files ignored by Git's .gitignore rules.
    # The --error-unmatch option is typically used to check for the existence of specific files,
    # but in this context, we avoid it to correctly handle the detection of any untracked files.
    untracked_files=$(git ls-files --others --exclude-standard)

    if [[ -n "$untracked_files" ]]; then
        echo "Untracked files detected:"
        echo "$untracked_files"
        
    else
        echo "Clear. No new files."
    fi
else
    echo "Path doesn't exist."
fi