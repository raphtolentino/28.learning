#!/bin/bash
# Count SSH login failures via journalctl

LOGFILE_UNIT="sshd"
SINCE="${1:-today}"

# Count “Failed password” entries since the given time
journalctl -u "$LOGFILE_UNIT" --since "$SINCE" \
  | grep -c "Failed password" \
  || echo 0
