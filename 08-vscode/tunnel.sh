#!/bin/bash
# Usage: ./tunnel.sh <login_host> <compute_node> <remote_port> [local_port]
# Run on your laptop (or the JupyterHub host).
set -euo pipefail
LOGIN=${1:?login host}; NODE=${2:?compute node}; RPORT=${3:?remote port}; LPORT=${4:-8080}

# Jump through the login node straight to the compute node's loopback.
exec ssh -N \
    -o ExitOnForwardFailure=yes \
    -o ServerAliveInterval=30 \
    -J "$LOGIN" \
    -L "${LPORT}:127.0.0.1:${RPORT}" \
    "$NODE"
# If compute nodes don't accept direct SSH, use instead:
#   ssh -N -L ${LPORT}:${NODE}:${RPORT} $LOGIN
# (then code-server must bind to 0.0.0.0, less secure)
