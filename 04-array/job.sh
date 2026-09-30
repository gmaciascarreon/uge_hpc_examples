#!/bin/bash
#$ -N array_job
#$ -cwd
#$ -S /bin/bash
#$ -o logs/$JOB_NAME.$JOB_ID.$TASK_ID.out
#$ -j y
#$ -t 1-20                    # one task per line in inputs.txt
#$ -tc 5                      # max 5 tasks running at once
#$ -l h_rt=00:05:00
#$ -l h_vmem=1G

set -euo pipefail
INPUT=$(sed -n "${SGE_TASK_ID}p" inputs.txt)
echo "Task $SGE_TASK_ID processing $INPUT on $(hostname)"
python3 process.py "$INPUT" > "results/out_${SGE_TASK_ID}.txt"
