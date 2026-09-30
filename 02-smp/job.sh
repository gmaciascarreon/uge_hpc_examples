#!/bin/bash
#$ -N smp_job
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -pe smp 8                  # 8 slots on ONE host (PE allocation_rule $pe_slots)
#$ -l h_rt=00:15:00
#$ -l h_vmem=1G               # per slot -> 8G total

set -euo pipefail
export OMP_NUM_THREADS=$NSLOTS
echo "NSLOTS=$NSLOTS on $(hostname)"
./omp_hello
