# generate_report.sh
#!/bin/bash
# Assemble a daily SSH failure report using the journal helpers

DATE="${1:-$(date +%F)}"
SINCE_TIME="${2:-today}"
THRESHOLD="${3:-5}"
REPORT_DIR="$HOME/reports"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

failures="$("$SCRIPT_DIR/count_failures.sh" "$SINCE_TIME")"
top5="$("$SCRIPT_DIR/top_ips.sh" "$SINCE_TIME")"
errors="$("$SCRIPT_DIR/service_errors.sh" "$SINCE_TIME")"

report=$(cat <<-EOF
============================
 Daily SSH Failure Report
 Date: $DATE
 Since: $SINCE_TIME
============================

Total SSH login failures: $failures
$( ((failures > THRESHOLD)) && echo "!!! ALERT: Failures exceed threshold of $THRESHOLD")

Top 5 offending IPs:
$top5

Services reporting errors:
$errors

EOF
)

# Output & save
echo "$report"
mkdir -p "$REPORT_DIR"
echo "$report" > "$REPORT_DIR/report-$DATE.txt"
