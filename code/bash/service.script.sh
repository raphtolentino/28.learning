#!/bin/bash

read -p "Enter the service name to check: " SERVICE
STATUS=$(systemctl is-active $SERVICE)

if [[ "$STATUS" == "inactive" || "$STATUS" == "failed" ]]; then
  echo "$(date): $SERVICE was $STATUS. Restarting..." | tee -a ~/logs/service.log
  sudo systemctl restart $SERVICE
else
  echo "$(date): $SERVICE is active." | tee -a ~/logs/service.log
fi
