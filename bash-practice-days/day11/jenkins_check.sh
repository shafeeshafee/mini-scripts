#!/bin/bash

# Purpose: script that checks if Jenkins is running and its associated port is open. If the service is running but the port is closed, attempts to open the port using firewall rules. If the service is not running, starts the service and open the port.

# Notes:
# Check Jenkins Status: sudo systemctl status jenkins
# Port Jenkins runs on: 8080
# Getting PID of Jenkins, use pidof: `pidof jenkins`
# Opening up a port: `sudo ufw allow 8080` (this is for Ubuntu based systems)
# Checking port status to see if it opened: `sudo ufw status`

# check if Jenkins is running
sudo systemctl status jenkins > /dev/null
jenkins_is_running=$?

# PID of Jenkins
PID=$(pidof jenkins)

# check if port 8080 (Jenkins' port) is allowing traffic
sudo ufw status | grep 8080 > /dev/null
port_allows_8080=$?

echo "Checking if Jenkins is running..."
if [ "$jenkins_is_running" -eq 0 ]; then
    echo "Jenkins is running (PID: $PID)."
else
    echo "Jenkins isn't running."
    echo "Attempting to start Jenkins..."
    sudo systemctl start jenkins
    # sleep allows time for Jenkins to start up
    sleep 2 
    PID=$(pidof jenkins)
    if [ -n "$PID" ]; then
        echo "Jenkins has been started (PID: $PID)."
    else
        echo "Failed to start Jenkins."
        exit 1
    fi
fi

echo "Checking if port 8080 is open..."
if [ "$port_allows_8080" -eq 0 ]; then
    echo "Port 8080 is open."
else
    echo "Port 8080 is closed."
    echo "Attempting to open port 8080 using firewall rules..."
    sudo ufw allow 8080
    sudo systemctl restart jenkins
    sleep 2 
    sudo ufw status | grep 8080 > /dev/null
    port_allows_8080=$?
    if [ "$port_allows_8080" -eq 0 ]; then
        echo "Port 8080 was been successfully opened."
    else
        echo "Failed to open port 8080."
        exit 1
    fi
fi

echo "Jenkins is now running and accessible on port 8080."




