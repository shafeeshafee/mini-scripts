#!/bin/bash
#
# permission_checker.sh
# ---------------------
# Purpose:
#   Checks if a file is readable (4), writable (2), and/or executable (1),
#   summing up to a numeric permission level from 0 to 7.
#
# Usage:
#   ./permission_checker.sh <file>
#
# Example:
#   ./permission_checker.sh sample.txt

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "Error: '$FILE' is not a valid file."
  exit 1
fi

perm_value=0
[ -r "$FILE" ] && perm_value=$((perm_value+4))
[ -w "$FILE" ] && perm_value=$((perm_value+2))
[ -x "$FILE" ] && perm_value=$((perm_value+1))

echo "Permission level for '$FILE': $perm_value (out of 7)"
