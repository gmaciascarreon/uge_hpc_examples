#!/bin/bash
#$ -N prep
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -l h_rt=00:05:00
#$ -l h_vmem=1G
set -euo pipefail
echo "Preparing data on $(hostname)"
seq 1 100000 > data/raw.txt
echo "prep done"
