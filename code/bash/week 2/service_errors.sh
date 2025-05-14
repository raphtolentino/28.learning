# service_errors.sh
#!/bin/bash
# Summarize “error” messages across all units via journalctl

SINCE="${1:-today}"

journalctl --since "$SINCE" \
  | grep -i "error" \
  | awk '{print $5}' \
  | cut -d'[' -f1 \
  | sort | uniq -c \
  | sort -nr
