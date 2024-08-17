#!/bin/bash

Public_IP="Public IP"
Private_IP="Private IP"
Current_User="The current user"
CPU_Information="CPU Information"
Memory_Information="Memory Information"
Top_5_Memory_Processes="Top 5 Memory Processes"
Top_5_CPU_Processes="Top 5 CPU Processes"
Network_Connectivity_Test="Network connectivity test"

choices=("$Public_IP" "$Private_IP" "$Current_User" "$CPU_Information" "$Memory_Information" "$Top_5_Memory_Processes" "$Top_5_CPU_Processes" "$Network_Connectivity_Test" "Exit")

while true; do
    select choice in "${choices[@]}"; do
        case $choice in
            "$Public_IP")
                public_ip=$(curl -s ifconfig.me)
                echo "Your Public IP is: $public_ip"
                break
                ;;
            "$Private_IP")
                private_ip=$(hostname -I | awk '{print $1}')
                echo "Your Private IP is: $private_ip"
                break
                ;;
            "$Current_User")
                current_user=$(whoami)
                echo "The current user is: $current_user"
                break
                ;;
            "$CPU_Information")
                cpu_info=$(lscpu | grep "Model name")
                cores=$(nproc)
                echo "This system has $cores CPU."
                echo "CPU Information: $cpu_info"
                break
                ;;
            "$Memory_Information")
                memory_info=$(free -h)
                echo "Memory Information:"
                echo "$memory_info"
                break
                ;;
            "$Top_5_Memory_Processes")
                echo "Top 5 Memory Processes:"
                ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -6
                break
                ;;
            "$Top_5_CPU_Processes")
                echo "Top 5 CPU Processes:"
                ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
                break
                ;;
            "$Network_Connectivity_Test")
                read -p "Enter a website or IP to ping: " target
                ping -c 4 "$target"
                break
                ;;
            "Exit")
                echo "Exiting now..."
                exit 0
                ;;
            *)
                echo "Error, choose a valid option."
                ;;
        esac
    done
done
