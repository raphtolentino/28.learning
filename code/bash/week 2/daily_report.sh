# daily-report.sh
#!/bin/bash
# Wrapper: menu or quick mode to generate the journalctl-based report

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<-EOU
Usage: $0 [quick] [-d DATE] [-s SINCE] [-t THRESHOLD]
  quick           Run report immediately and exit
  -d DATE         Report label (YYYY-MM-DD), default: today
  -s SINCE        Since time for journalctl, default: today
  -t THRESHOLD    Failure alert threshold, default: 5
EOU
  exit 1
}

# Defaults
DATE=""
SINCE=""
THRESHOLD=""

# Parse flags
while getopts ":d:s:t:h" opt; do
  case $opt in
    d) DATE="$OPTARG" ;;
    s) SINCE="$OPTARG" ;;
    t) THRESHOLD="$OPTARG" ;;
    h|*) usage ;;
  esac
done
shift $((OPTIND-1))

# Quick mode
if [[ "$1" == "quick" ]]; then
  exec "$SCRIPT_DIR/generate_report.sh" "$DATE" "$SINCE" "$THRESHOLD"
fi

# Interactive menu
while true; do
  cat <<-MENU

    === Daily SSH Report Menu ===
    1) Generate report
    2) Quick report (no menu)
    3) Usage
    4) Quit
MENU
  read -p "Choose [1-4]: " CHOICE
  case $CHOICE in
    1) "$SCRIPT_DIR/generate_report.sh" "$DATE" "$SINCE" "$THRESHOLD" ;;
    2) exec "$SCRIPT_DIR/generate_report.sh" "$DATE" "$SINCE" "$THRESHOLD" ;;
    3) usage ;;
    4) echo "Goodbye."; exit 0 ;;
    *) echo "Invalid choice. Please select 1–4." ;;
  esac
done
