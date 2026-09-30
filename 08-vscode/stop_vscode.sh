#!/bin/bash
# Usage: ./stop_vscode.sh <job_id>   (or 'all' for every vscode_session job)
set -euo pipefail
if [[ "${1:-}" == "all" ]]; then
    qstat -u "$USER" | awk '$3 ~ /^vscode_se/ {print $1}' | xargs -r qdel
else
    qdel "${1:?job id}"
    rm -f "$HOME/.vscode-jobs/$1".{endpoint,password}
fi
