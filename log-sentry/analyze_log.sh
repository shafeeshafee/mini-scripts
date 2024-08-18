#!/bin/bash

# Log file we are analyzing
LOGS="/var/log/auth_log.log"

# Where suspicious logs get written
OUTPUT="suspicious_activity.log"

SUSPICIOUS_WORDS=("failed" "unauthorized" "error")

# If suspicious_activity.log doesn't exist, create it
if [ ! -f "$OUTPUT" ]; then
  touch "$OUTPUT"
fi

# Go through each line
while read -r line; do
  for word in "${SUSPICIOUS_WORDS[@]}"
  do
    # Make everything lower case
    lowercase_line=$(echo "$line" | tr '[:upper:]' '[:lower:]')
    # If it contains a word from the suspicious keyword, append that line to suspicious_attempts.log
    if [[ "$lowercase_line" == *"$word"* ]]; then
    echo "$line" >> "$OUTPUT"
    # Break; then go to the next iteration (line)
    break
    fi
  done
# Standard way to go through a file with while loop, input redirection
done < "$LOGS"