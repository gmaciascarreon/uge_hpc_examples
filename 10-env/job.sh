#!/bin/bash
#$ -N env_dump
#$ -cwd
#$ -S /bin/bash
#$ -o logs/
#$ -j y
#$ -pe smp 2
#$ -l h_rt=00:02:00
#$ -l h_vmem=512M

for v in JOB_ID JOB_NAME SGE_TASK_ID NSLOTS NHOSTS NQUEUES QUEUE HOSTNAME \
         PE PE_HOSTFILE TMPDIR SGE_O_WORKDIR SGE_O_HOST SGE_O_LOGNAME \
         SGE_CELL SGE_ROOT SGE_STDOUT_PATH RESTARTED; do
    printf '%-18s %s\n' "$v" "${!v:-<unset>}"
done
echo; echo "--- PE_HOSTFILE ---"; cat "${PE_HOSTFILE:-/dev/null}"
echo; echo "--- all SGE_* ---";  env | grep '^SGE_' | sort
