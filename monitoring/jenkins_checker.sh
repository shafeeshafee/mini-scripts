#!/bin/bash
#
# jenkins_checker.sh
# ------------------
# Purpose:
#   Checks if Jenkins is running and if port 8080 is open. If Jenkins is
#   not running, starts it. If 8080 is closed, opens it via UFW.
#
# Usage:
#   sudo ./jenkins_checker.sh
#
# Notes:
#   - For Debian/Ubuntu systems with systemctl and ufw.

SERVICE="jenkins"
PORT="8080"

echo "Checking if $SERVICE is running..."
if systemctl is-active --quiet "$SERVICE"; then
  PID=$(pidof "$SERVICE")
  echo "$SERVICE is running (PID: $PID)."
else
  echo "$SERVICE is not running. Attempting to start..."
  sudo systemctl start "$SERVICE"
  sleep 3
  if pidof "$SERVICE" &>/dev/null; then
    echo "$SERVICE started successfully."
  else
    echo "Failed to start $SERVICE."
    exit 1
  fi
fi

echo "Checking port $PORT..."
sudo ufw status | grep -q "$PORT"
if [ $? -ne 0 ]; then
  echo "Port $PORT is closed. Opening via UFW..."
  sudo ufw allow "$PORT"
  sudo systemctl restart "$SERVICE"
  sleep 2
  sudo ufw status | grep -q "$PORT" && echo "Port $PORT is now open." || echo "Failed to open port $PORT."
else
  echo "Port $PORT is already open."
fi

echo "All done. Jenkins should be running on port $PORT."
