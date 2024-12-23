#!/bin/bash
#
# empty_file_remover.sh
# ---------------------
# Purpose:
#   Find empty files and directories in the current folder. Lets the user
#   delete them if desired. Helps keep things tidy.
#
# Usage:
#   ./empty_file_remover.sh
#
# Notes:
#   - Directories are considered empty if they contain no files or subdirs.
#   - Use with caution; it permanently removes items.

empty_files=()
empty_dirs=()

# Check all items in current directory
for item in *; do
  if [ -d "$item" ]; then
    # Check if directory is empty
    if [ -z "$(ls -A "$item" 2>/dev/null)" ]; then
      empty_dirs+=("$item")
    fi
  elif [ -f "$item" ]; then
    # Check if file is empty
    if [ ! -s "$item" ]; then
      empty_files+=("$item")
    fi
  fi
done

if [ ${#empty_files[@]} -eq 0 ] && [ ${#empty_dirs[@]} -eq 0 ]; then
  echo "No empty files or folders found."
  exit 0
fi

echo "Empty directories:"
for d in "${empty_dirs[@]}"; do
  echo "  - $d"
done

echo ""
echo "Empty files:"
for f in "${empty_files[@]}"; do
  echo "  - $f"
done

read -p "Delete these empty items? (y/n): " choice

case "$choice" in
  y|Y)
    echo "Deleting empty items..."
    for f in "${empty_files[@]}"; do
      rm "$f" && echo "Deleted file: $f"
    done
    for d in "${empty_dirs[@]}"; do
      rmdir "$d" && echo "Deleted directory: $d"
    done
    ;;
  *)
    echo "No deletions performed."
    ;;
esac
