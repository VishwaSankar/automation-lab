#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOGDIR="$PROJECT_DIR/logs"

mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/sysreport_$(date +%F).log"

{
    echo "================================"
    echo "SYSTEM REPORT"
    echo "================================"
    echo "Date: $(date)"
    echo "User: $(whoami)"
    echo "Hostname: $(hostname)"
    echo "System: $(uname -a)"
    echo "Disk Usage:"
    df -h
    echo "Memory Usage:"
    free -h
    echo "System Uptime:"
    uptime
    echo "Report completed successfully"
    echo "================================"
} >> "$LOGFILE"

echo "Report saved: $LOGFILE"
