#!/bin/bash
set -e
# module load gcc   # uncomment if your cluster uses environment modules
gcc -O2 -fopenmp omp_hello.c -o omp_hello
echo "Built ./omp_hello"
