#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

echo "Generating system report..."
bash scripts/sysreport.sh

echo "Validating Bash scripts..."
bash -n scripts/sysreport.sh
bash -n scripts/run_and_commit.sh

echo "Staging reports..."
git add logs/sysreport_*.log

if ! git diff --cached --quiet; then
    git commit -m "Automatic system report $(date '+%F %T')"
else
    echo "No report changes to commit"
fi

if git remote get-url origin >/dev/null 2>&1; then
    git push -u origin "$(git branch --show-current)"
fi

echo "Automation completed"
