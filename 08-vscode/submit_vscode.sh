#!/bin/bash
# Usage: ./submit_vscode.sh <cluster> [hours] [slots] [mem_per_slot] [gpus]
# Run on the cluster's login node.
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
CLUSTER=${1:?cluster name from clusters.conf}
HOURS=${2:-8}; SLOTS=${3:-4}; MEM=${4:-4G}; GPUS=${5:-0}

read -r _ LOGIN QUEUE PE MEMC GPUC < <(grep -E "^${CLUSTER}[[:space:]]" "$HERE/clusters.conf") \
  || { echo "Unknown cluster: $CLUSTER"; exit 1; }

mkdir -p "$HOME/.vscode-jobs"
RES="h_rt=$(printf '%02d' "$HOURS"):00:00,$MEMC=$MEM"
[[ "$GPUS" -gt 0 ]] && RES="$RES,$GPUC=$GPUS"

JOB=$(qsub -terse -q "$QUEUE" -pe "$PE" "$SLOTS" -l "$RES" \
      -o "$HOME/.vscode-jobs/" -wd "$HOME" "$HERE/vscode_job.sh")
echo "Submitted job $JOB on $CLUSTER; waiting for it to start..."

EP="$HOME/.vscode-jobs/$JOB.endpoint"
for _ in $(seq 1 120); do
    [[ -s "$EP" ]] && break
    sleep 5
done
[[ -s "$EP" ]] || { echo "Not started after 10 min. Check: qstat -j $JOB"; exit 1; }

IFS=: read -r NODE PORT < "$EP"
echo
echo "Running on $NODE:$PORT"
echo "Password: $(cat "$HOME/.vscode-jobs/$JOB.password")"
echo
echo "From your machine run:"
echo "  ./tunnel.sh $LOGIN $NODE $PORT"
echo "Then open http://localhost:8080"
echo "Stop with: ./stop_vscode.sh $JOB"
