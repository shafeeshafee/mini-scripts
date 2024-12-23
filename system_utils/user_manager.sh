#!/bin/bash
#
# user_manager.sh
# ---------------
# Purpose:
#   Reads a list of usernames from a file, checks if each exists, and prints
#   their home directory and shell. If missing, creates them with 'useradd'.
#
# Usage:
#   sudo ./user_manager.sh <user_list.txt>
#
# Notes:
#   - Must run as root or with sudo to create users.
#   - This is a simple example, not production-hardened.

FILE_LIST="$1"

if [ -z "$FILE_LIST" ]; then
  echo "Usage: $0 <user_list_file>"
  exit 1
fi

if [ ! -f "$FILE_LIST" ]; then
  echo "No such file: '$FILE_LIST'"
  exit 1
fi

while IFS= read -r USERNAME; do
  if [ -z "$USERNAME" ]; then
    continue
  fi
  if getent passwd "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' exists."
    HOME_DIR=$(getent passwd "$USERNAME" | cut -d: -f6)
    SHELL=$(getent passwd "$USERNAME" | cut -d: -f7)
    echo "  Home:  $HOME_DIR"
    echo "  Shell: $SHELL"
  else
    echo "User '$USERNAME' does not exist. Creating..."
    useradd -m "$USERNAME"
    if [ $? -eq 0 ]; then
      HOME_DIR=$(getent passwd "$USERNAME" | cut -d: -f6)
      SHELL=$(getent passwd "$USERNAME" | cut -d: -f7)
      echo "User '$USERNAME' created."
      echo "  Home:  $HOME_DIR"
      echo "  Shell: $SHELL"
    else
      echo "Failed to create user '$USERNAME'."
    fi
  fi
done < "$FILE_LIST"
