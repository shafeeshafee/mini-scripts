#!/bin/bash
#
# word_count.sh
# -------------
# Purpose:
#   Counts occurrences of a specific word/pattern in a given text file.
#
# Usage:
#   ./word_count.sh <file>
#
# Notes:
#   - Uses 'grep -ci' to do a case-insensitive search.

TARGET_FILE="$1"

if [ ! -f "$TARGET_FILE" ]; then
  echo "Error: file '$TARGET_FILE' doesn't exist."
  exit 1
fi

read -p "Enter the word/pattern to count: " PATTERN
OCCURRENCES=$(grep -ci "$PATTERN" "$TARGET_FILE")

echo "Found '$PATTERN' $OCCURRENCES times in '$TARGET_FILE'."
