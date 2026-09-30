#!/bin/bash
set -e
module load openmpi 2>/dev/null || true
mpicc -O2 mpi_hello.c -o mpi_hello
echo "Built ./mpi_hello"
