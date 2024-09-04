#!/bin/bash

# arrays to store empty files and folders
empty_files=()
empty_dirs=()

# The wildcard * represents all files and directories in cwd
for item in *; do
    if [ -d "$item" ]; then 
        if [ -z "$(ls -A "$item" 2>/dev/null)" ]; then
            empty_dirs+=("$item") 
        fi
    elif [ -f "$item" ]; then
        if [ ! -s "$item" ]; then
            empty_files+=("$item")
        fi
    fi
done

# check if both arrays are empty
if [ ${#empty_files[@]} -eq 0 ] && [ ${#empty_dirs[@]} -eq 0 ]; then
    echo "No empty files or folders. All clear!"
    exit 0
else
    echo -e "Found empty items. Check below...\n"
    # Display empty dirs:
    if [ ${#empty_dirs[@]} -gt 0 ]; then
        echo "Empty directories:"
        for dir in "${empty_dirs[@]}"; do
            echo "- $dir"
        done
    fi
    # Display empty files:
    if [ ${#empty_files[@]} -gt 0 ]; then
        echo " " 
        echo "Empty files:"
        for file in "${empty_files[@]}"; do
            echo "- $file"
        done
    fi
fi

read -p "Would you like to delete these empty items? (y/n)" choice

# loops confirmation menu, asking if the user if they want to delete
while true; do

    case "$choice" in
        # if yes
        y|Y )
            echo "Deleting empty items..."

            # Delete empty files
            if [ ${#empty_files[@]} -gt 0 ]; then
                for file in "${empty_files[@]}"; do
                    rm "$file"
                    echo "Deleted file: $file"
                done
            fi

            # Delete empty directories
            if [ ${#empty_dirs[@]} -gt 0 ]; then
                for dir in "${empty_dirs[@]}"; do
                    rmdir "$dir"
                    echo "Deleted directory: $dir"
                done
            fi

            echo "Deletions complete!"
            break
            ;;
        n|N )
            echo "Leaving empty files in."
            exit 0
            ;;
        * )
            echo "Invalid choice. Please enter y or no."
            ;;
        esac
done

