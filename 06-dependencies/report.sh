#!/bin/bash
#$ -N report
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -l h_rt=00:05:00
#$ -l h_vmem=1G
set -euo pipefail
{
  echo "Pipeline report - $(date)"
  cat data/analysis.txt
} > data/report.txt
cat data/report.txt
