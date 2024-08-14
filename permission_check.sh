#!/bin/bash

# purpose: a script to check if a file is readable, writable, and executable.

# [ -r ] [ -w ] [ -x ] commands are used to denote if a file is readable, writeable, and executable

# Set counter for 0, to store permission total

# Read, 4
# Write, 2
# Execute, 1

# since 7 is the highest number in terms of permissions, add to the counter whenever a permission is met or isn't

# If file is readable add 4 to counter
# If file is writeable add 2 to counter
# If file is executeable, add 1 to counter 

# todo: assume file doesn't exist, make a check for that
filename='sample.txt'

# If file is readable add 4 to counter
if [ -r "$filename" ]; then
    echo "File is readable"
    counter=$((counter + 4))
fi
