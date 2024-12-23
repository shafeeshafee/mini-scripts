#!/bin/bash
#
# url_checker.sh
# --------------
# Purpose:
#   Checks if a given URL is reachable and prints the HTTP status code.
#
# Usage:
#   ./url_checker.sh <http://example.com>
#
# Notes:
#   - Uses 'curl -I' to fetch headers, extracting status code from the first line.

URL="$1"

if [[ -z "$URL" ]]; then
  echo "Usage: $0 <URL>"
  exit 1
fi

STATUS_CODE=$(curl -Is "$URL" 2>/dev/null | head -n1 | awk '{print $2}')

if [[ -z "$STATUS_CODE" ]]; then
  echo "Could not retrieve HTTP status. Site may be down or invalid."
  exit 1
fi

# First digit of status
case "${STATUS_CODE:0:1}" in
  1) echo "Informational response (HTTP ${STATUS_CODE})." ;;
  2) echo "Success reaching ${URL} (HTTP ${STATUS_CODE})." ;;
  3) echo "Redirection response (HTTP ${STATUS_CODE})." ;;
  4) echo "Client error (HTTP ${STATUS_CODE})." ;;
  5) echo "Server error (HTTP ${STATUS_CODE})." ;;
  *) echo "Unexpected status code: ${STATUS_CODE}." ;;
esac
