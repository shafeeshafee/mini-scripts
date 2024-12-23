#!/bin/bash
#
# file_checker.sh
# ---------------
# Purpose:
#   Checks if a given file exists, then prints its size in KB or MB.
#
# Usage:
#   ./file_checker.sh <file_name>
#
# Example:
#   ./file_checker.sh mydata.txt
#
# Notes:
#   - Uses 'du' to retrieve file size.

TARGET_FILE="$1"

if [[ ! -f "$TARGET_FILE" ]]; then
  echo "File '$TARGET_FILE' does not exist."
  exit 1
fi

FILE_SIZE_KB=$(du -k "$TARGET_FILE" | cut -f1)

if [ "$FILE_SIZE_KB" -ge 1000 ]; then
  FILE_SIZE_MB=$(echo "scale=1; $FILE_SIZE_KB / 1000" | bc)
  echo "File size of '$TARGET_FILE' is about $FILE_SIZE_MB MB."
else
  echo "File size of '$TARGET_FILE' is ${FILE_SIZE_KB} KB."
fi
