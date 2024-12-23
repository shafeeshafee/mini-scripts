#!/bin/bash
#
# bash_file_monitor.sh
# --------------------
# Purpose:
#   Finds all *.sh files (in /home/ubuntu by default) and makes them executable.
#   Primarily for educational/demonstration usage.
#
# Usage:
#   ./bash_file_monitor.sh
#
# Notes:
#   - This can be dangerous on multi-user systems. Adjust the path as needed.

SEARCH_DIR="/home/ubuntu"

echo "Searching for *.sh files in '$SEARCH_DIR'..."

while IFS= read -r -d '' FILE; do
  if [ ! -x "$FILE" ]; then
    echo "Found non-executable bash file: $FILE"
    chmod +x "$FILE"
    echo "Made '$FILE' executable."
  fi
done < <(find "$SEARCH_DIR" -type f -name "*.sh" -print0 2>/dev/null)

echo "Done."
