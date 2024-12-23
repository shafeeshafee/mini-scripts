#!/bin/bash
#
# backup_check.sh
# ---------------
# Purpose:
#   Checks if a directory named 'backup' exists in the current directory.
#   If not, creates it. Helps ensure local backups have a ready folder.
#
# Usage:
#   ./backup_check.sh
#
# Notes:
#   - Modify 'BACKUP_DIR_NAME' if you want a different folder name.

BACKUP_DIR_NAME="backup"

if [ -d "$BACKUP_DIR_NAME" ]; then
  echo "Backup directory '$BACKUP_DIR_NAME' already exists."
else
  echo "No backup directory found. Creating '$BACKUP_DIR_NAME'..."
  mkdir "$BACKUP_DIR_NAME" && echo "Created directory '$BACKUP_DIR_NAME'."
fi
