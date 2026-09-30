#!/bin/bash
# Wrappers for interactive UGE sessions.
# Usage: ./interactive.sh [shell|cmd|login|gpu] [hours] [slots] [mem_per_slot]
MODE=${1:-shell}; HOURS=${2:-1}; SLOTS=${3:-1}; MEM=${4:-4G}
RES="h_rt=$(printf '%02d' "$HOURS"):00:00,h_vmem=$MEM"
PE=""; [[ "$SLOTS" -gt 1 ]] && PE="-pe smp $SLOTS"

case "$MODE" in
  shell) exec qrsh -l "$RES" $PE -now no bash -l ;;
  cmd)   exec qrsh -l "$RES" $PE -now no -cwd python3 -c 'import socket; print(socket.gethostname())' ;;
  login) exec qlogin -l "$RES" $PE ;;
  gpu)   exec qrsh -l "$RES,gpu=1" $PE -now no bash -l ;;
  *) echo "Usage: $0 [shell|cmd|login|gpu] [hours] [slots] [mem_per_slot]"; exit 1 ;;
esac
# -now no: wait in the queue instead of failing when no slot is free right now.
