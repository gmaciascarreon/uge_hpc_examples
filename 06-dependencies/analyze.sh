#!/bin/bash
#$ -N analyze
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -l h_rt=00:05:00
#$ -l h_vmem=1G
set -euo pipefail
awk '{s+=$1} END {print "sum=" s, "count=" NR}' data/raw.txt > data/analysis.txt
cat data/analysis.txt
