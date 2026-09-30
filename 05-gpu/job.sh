#!/bin/bash
#$ -N gpu_job
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -l gpu=1                   # complex name varies: gpu, gpus, ngpus
##$ -q gpu.q                  # uncomment if GPUs are in a separate queue
#$ -l h_rt=00:20:00
#$ -l h_vmem=8G

set -euo pipefail
module load cuda 2>/dev/null || true

# Some sites set CUDA_VISIBLE_DEVICES; others expose SGE_HGR_gpu (RSMAP).
if [[ -z "${CUDA_VISIBLE_DEVICES:-}" && -n "${SGE_HGR_gpu:-}" ]]; then
    export CUDA_VISIBLE_DEVICES=$(echo "$SGE_HGR_gpu" | tr ' ' ',')
fi
python3 gpu_check.py
