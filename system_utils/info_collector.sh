#!/bin/bash
#
# info_collector.sh
# -----------------
# Purpose:
#   Provides a simple menu to view system info: Public IP, Private IP,
#   current user, CPU info, memory info, top processes, and a ping test.
#
# Usage:
#   ./info_collector.sh
#
# Notes:
#   - Press Ctrl+C to exit anytime from the menu loop.

PUBLIC_IP="Public IP"
PRIVATE_IP="Private IP"
CURRENT_USER="Current User"
CPU_INFO="CPU Information"
MEM_INFO="Memory Information"
TOP_MEM="Top 5 Memory Processes"
TOP_CPU="Top 5 CPU Processes"
NET_TEST="Network Connectivity Test"
MENU_EXIT="Exit"

CHOICES=("$PUBLIC_IP" "$PRIVATE_IP" "$CURRENT_USER" "$CPU_INFO" "$MEM_INFO" "$TOP_MEM" "$TOP_CPU" "$NET_TEST" "$MENU_EXIT")

while true; do
  echo "Select an option:"
  select choice in "${CHOICES[@]}"; do
    case "$choice" in
      "$PUBLIC_IP")
        echo "Public IP: $(curl -s ifconfig.me)"
        break
        ;;
      "$PRIVATE_IP")
        echo "Private IP: $(hostname -I | awk '{print $1}')"
        break
        ;;
      "$CURRENT_USER")
        echo "Current user: $(whoami)"
        break
        ;;
      "$CPU_INFO")
        echo "CPU Info:"
        lscpu | grep -E "Model name|Socket"
        echo "Number of cores: $(nproc)"
        break
        ;;
      "$MEM_INFO")
        echo "Memory Info (free -h):"
        free -h
        break
        ;;
      "$TOP_MEM")
        echo "Top 5 Memory Processes:"
        ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -6
        break
        ;;
      "$TOP_CPU")
        echo "Top 5 CPU Processes:"
        ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
        break
        ;;
      "$NET_TEST")
        read -p "Enter a hostname/IP to ping: " TARGET
        ping -c 4 "$TARGET"
        break
        ;;
      "$MENU_EXIT")
        echo "Exiting."
        exit 0
        ;;
      *)
        echo "Invalid choice."
        ;;
    esac
  done
done
