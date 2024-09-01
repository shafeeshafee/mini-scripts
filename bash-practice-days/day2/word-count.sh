#!/bin/bash

# Purpose: a script that counts the occurrences of a specific word chosen by the user in a given text file.

filename=$1

if [ ! -f $filename ]; then
    echo "Error, file $filename doesn't exist."
else
    read -p "Enter the word/pattern you want to count: " user_input
    echo "Counting occurences of $user_input in $filename..."
    occurences=$(grep -ci $user_input $filename)
    echo "Found $user_input $occurences times." 
fi