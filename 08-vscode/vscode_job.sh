#!/bin/bash
#$ -N vscode_session
#$ -S /bin/bash
#$ -j y
# Queue, PE, memory and runtime are passed in by submit_vscode.sh.

set -euo pipefail
OUTDIR="$HOME/.vscode-jobs"
mkdir -p "$OUTDIR"; chmod 700 "$OUTDIR"

PORT=$(python3 -c 'import socket;s=socket.socket();s.bind(("127.0.0.1",0));print(s.getsockname()[1]);s.close()')
HOST=$(hostname -f)
PASSWORD=$(python3 -c 'import secrets;print(secrets.token_urlsafe(18))')

# Endpoint + password readable only by the user
umask 077
echo "$HOST:$PORT" > "$OUTDIR/$JOB_ID.endpoint"
echo "$PASSWORD"   > "$OUTDIR/$JOB_ID.password"

cleanup() { rm -f "$OUTDIR/$JOB_ID.endpoint" "$OUTDIR/$JOB_ID.password"; }
trap cleanup EXIT

echo "VS Code server: $HOST:$PORT (job $JOB_ID, slots ${NSLOTS:-1})"
export PASSWORD
exec code-server \
    --bind-addr "127.0.0.1:$PORT" \
    --auth password \
    --disable-telemetry \
    --user-data-dir "$HOME/.local/share/code-server" \
    "${SGE_O_WORKDIR:-$HOME}"
