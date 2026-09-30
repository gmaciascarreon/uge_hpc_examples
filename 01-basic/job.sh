#!/bin/bash
#$ -N basic_job
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -e logs/
#$ -l h_rt=00:10:00
#$ -l h_vmem=2G
##$ -q all.q                  # uncomment and set your queue
##$ -M you@example.com
##$ -m bea

set -euo pipefail
echo "Job $JOB_ID ($JOB_NAME) on $(hostname) at $(date)"
python3 my_script.py
echo "Done at $(date)"
