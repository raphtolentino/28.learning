
#!/bin/bash

LOGFILE=~/logs/diag-$(date +%F).log

echo "Select an option:"
echo "1. Disk usage"
echo "2. Top processes"
echo "3. IP information"
echo "4. Failed services"
read -p "Enter choice: " CHOICE

case $CHOICE in
  1) df -h | tee -a "$LOGFILE" ;;
  2) ps aux --sort=-%mem | head | tee -a "$LOGFILE" ;;
  3) ip a | tee -a "$LOGFILE" ;;
  4) systemctl --failed | tee -a "$LOGFILE" ;;
  *) echo "Invalid option" ;;
esac