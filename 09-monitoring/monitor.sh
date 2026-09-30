#!/bin/bash
# Handy wrappers around qstat/qacct/qhost.
# Usage: ./monitor.sh <command> [args]
set -uo pipefail
cmd=${1:-help}; shift || true
case "$cmd" in
  mine)     qstat -u "$USER" ;;
  all)      qstat -u '*' ;;
  why)      qstat -j "${1:?job id}" | grep -E -A20 'scheduling info|error reason' ;;
  detail)   qstat -j "${1:?job id}" ;;
  queues)   qstat -g c ;;
  hosts)    qhost ;;
  hostjobs) qhost -j -h "${1:?hostname}" ;;
  acct)     qacct -j "${1:?job id}" | grep -E 'jobname|hostname|exit_status|failed|ru_wallclock|maxvmem|slots|start_time|end_time' ;;
  failed)   qacct -o "$USER" -d "${1:-1}" -j | awk '/jobnumber/{j=$2} /exit_status/{if($2!=0) print "job",j,"exit",$2}' ;;
  watch)    watch -n 10 "qstat -u $USER" ;;
  killall)  read -rp "Delete ALL jobs of $USER? [y/N] " a; [[ $a == y ]] && qdel -u "$USER" ;;
  extend)   qalter -l h_rt="${2:?HH:MM:SS}" "${1:?job id}" ;;
  hold)     qhold "${1:?job id}" ;;
  release)  qrls "${1:?job id}" ;;
  *) cat <<USAGE
Usage: $0 <command>
  mine | all | queues | hosts | watch
  why <job>        pending reason
  detail <job>     full job info
  hostjobs <host>  jobs on a node
  acct <job>       accounting after finish (exit, maxvmem, wallclock)
  failed [days]    your non-zero exits in last N days
  extend <job> <HH:MM:SS>   change h_rt (pending jobs)
  hold|release <job>
  killall
USAGE
  ;;
esac
