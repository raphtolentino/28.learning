#!/bin/bash
#
# File: daily-report.sh
# Purpose: Parse SSH auth log and generate a daily report.
# Usage:
#   ./daily-report.sh               # uses default /var/log/auth.log and today’s date
#   ./daily-report.sh -f /path/log  # custom log file
#   ./daily-report.sh -d YYYY-MM-DD # custom date label
#

### ─── Configuration & Defaults ──────────────────────────────────────────
LOGFILE="/var/log/auth.log"
DATE=$(date +%F)
REPORT_DIR="$HOME/reports"
THRESHOLD=5

### ─── Helper: Show Usage ────────────────────────────────────────────────
usage() {
  cat <<-EOF
Usage: $0 [-f logfile] [-d YYYY-MM-DD] [-t threshold] [quick]
  -f FILE       Path to auth log (default: $LOGFILE)
  -d DATE       Label for report (default: $DATE)
  -t THRESHOLD  Alert threshold for failures (default: $THRESHOLD)
  quick         Run report once and exit (no menu)
EOF
  exit 1
}

### ─── Parse Options ─────────────────────────────────────────────────────
while getopts ":f:d:t:h" opt; do
  case $opt in
    f) LOGFILE="$OPTARG" ;;
    d) DATE="$OPTARG" ;;
    t) THRESHOLD="$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done
shift $((OPTIND-1))

### ─── Validation ───────────────────────────────────────────────────────
if [[ ! -r "$LOGFILE" ]]; then
  echo "ERROR: Cannot read log file: $LOGFILE" >&2
  exit 2
fi

### ─── Core Functions ───────────────────────────────────────────────────
count_failures() {
  grep -c "Failed password" "$LOGFILE" 2>/dev/null || echo 0
}

top_ips() {
  grep "Failed password" "$LOGFILE" 2>/dev/null \
    | awk '{print $(NF-3)}' \
    | sort | uniq -c \
    | sort -nr \
    | head -n5
}

service_errors() {
  grep -i "error" "$LOGFILE" 2>/dev/null \
    | awk '{print $5}' \
    | cut -d'[' -f1 \
    | sort | uniq -c \
    | sort -nr
}

generate_report() {
  local failures
  failures=$(count_failures)

  report_content=$(cat <<-EOF
  ============================
  Daily SSH Failure Report
  Date: $DATE
  Source: $LOGFILE
  ============================

  Total SSH login failures: $failures
  $( ((failures > THRESHOLD)) && echo "!!! ALERT: Failures exceed threshold of $THRESHOLD" )

  Top 5 offending IPs:
  $(top_ips)

  Services reporting errors:
  $(service_errors)

EOF
  )

  # Print to screen
  echo "$report_content"

  # Ensure report directory exists
  mkdir -p "$REPORT_DIR"
  # Save to file
  echo "$report_content" > "$REPORT_DIR/report-$DATE.txt"
}

### ─── Quick Mode ───────────────────────────────────────────────────────
if [[ "$1" == "quick" ]]; then
  generate_report
  exit 0
fi

### ─── Interactive Menu ─────────────────────────────────────────────────
show_menu() {
  cat <<-EOF
  ===== Daily Report Generator =====
  1) Generate report now
  2) Set report date (current: $DATE)
  3) Set failure threshold (current: $THRESHOLD)
  4) Show usage
  5) Quick mode (no menu)
  6) Quit
EOF
}

while true; do
  show_menu
  read -p "Enter choice [1-6]: " CHOICE
  case $CHOICE in
    1) generate_report ;;
    2) read -p "Enter new date (YYYY-MM-DD): " DATE ;;
    3) read -p "Enter new threshold: " THRESHOLD ;;
    4) usage ;;
    5) generate_report; exit 0 ;;
    6) echo "Exiting."; exit 0 ;;
    *) echo "Invalid choice. Please enter 1-6." ;;
  esac
  echo
done
