#!/bin/bash
# purpose: tool to check if a backup directory is in cwd

backup_dir_name="backup"

if [ -d "$backup_dir_name" ]; then
    echo "Backup already exists. You're good to go."
else   
    echo "Doesn't exist. Creating now..."

    mkdir "$backup_dir_name"

    echo "Created backup directory."
fi