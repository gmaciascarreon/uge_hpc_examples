#!/bin/bash
#$ -N mpi_job
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -pe mpi 32                 # PE name varies: mpi, orte, openmpi ...
#$ -l h_rt=00:30:00
#$ -l h_vmem=1G
#$ -V                         # export submit env (PATH to mpirun etc.)

set -euo pipefail
module load openmpi 2>/dev/null || true

echo "Slots: $NSLOTS"
echo "Hosts allocated:"
cat "$PE_HOSTFILE"

# Open MPI built with SGE support reads $PE_HOSTFILE automatically.
mpirun -np "$NSLOTS" ./mpi_hello
