#!/bin/bash
#
# process_checker.sh
# ------------------
# Purpose:
#   Checks if a given service/process is running via systemctl.
#
# Usage:
#   ./process_checker.sh <service_name>
#
# Example:
#   ./process_checker.sh nginx

SERVICE_NAME="$1"

if [ -z "$SERVICE_NAME" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi

if systemctl is-active --quiet "$SERVICE_NAME"; then
  echo "Process '$SERVICE_NAME' is running."
else
  echo "Process '$SERVICE_NAME' is not running."
fi
