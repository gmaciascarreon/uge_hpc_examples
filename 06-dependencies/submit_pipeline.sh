#!/bin/bash
# prep -> analyze -> report, each waits for the previous one.
set -euo pipefail
J1=$(qsub -terse prep.sh)
J2=$(qsub -terse -hold_jid "$J1" analyze.sh)
J3=$(qsub -terse -hold_jid "$J2" report.sh)
echo "Submitted: prep=$J1 analyze=$J2 report=$J3"
echo "Watch with: qstat -u $USER"
