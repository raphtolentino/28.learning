# top_ips.sh
#!/bin/bash
# List top 5 IPs causing SSH failures via journalctl

LOGFILE_UNIT="sshd"
SINCE="${1:-today}"

journalctl -u "$LOGFILE_UNIT" --since "$SINCE" \
  | grep "Failed password" \
  | awk '{print $(NF-3)}' \
  | sort | uniq -c \
  | sort -nr \
  | head -n5
