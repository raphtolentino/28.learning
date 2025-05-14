#!/bin/bash

options=(
"Network Interfaces"
"Test Connectivity"
"List Running Service"
"Show System uptime"
"Quit"
)

PS3 = "Enter choice [1-${#options[@]}:"

while true; do
  echo
  select opt in "${options[@]}"; do
    case $REPLY in
      1) ip a; break ;;
      2) ping -c 3 google.com; break ;;
      3) ss -tulpn; break ;;
      4) uptime; break ;;
      5) echo "Goodbye!"; exit 0 ;;
      *) echo "Invalid option. Try again."; break ;;
    esac
  done
done
