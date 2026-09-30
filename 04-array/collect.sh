#!/bin/bash
# Run after the array finishes (or submit with: qsub -hold_jid <array_id> -cwd -b y ./collect.sh)
cat results/out_*.txt | sort -V > results/summary.txt
echo "Wrote results/summary.txt ($(wc -l < results/summary.txt) lines)"
