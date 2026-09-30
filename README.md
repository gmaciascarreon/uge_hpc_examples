# UGE (Univa / Altair Grid Engine) Examples

Each folder is self-contained: `cd` into it and follow the "Run" line.

| Folder | What it shows | Run |
|---|---|---|
| 01-basic | Minimal batch job | `qsub job.sh` |
| 02-smp | Multi-threaded (OpenMP) on one node | `./build.sh && qsub job.sh` |
| 03-mpi | MPI across nodes | `./build.sh && qsub job.sh` |
| 04-array | Array job over an input list | `./make_inputs.sh && qsub job.sh` |
| 05-gpu | GPU job | `qsub job.sh` |
| 06-dependencies | Pipeline with -hold_jid | `./submit_pipeline.sh` |
| 07-interactive | qrsh / qlogin wrappers | `./interactive.sh` |
| 08-vscode | VS Code server as a job + SSH tunnel | see 08-vscode/README.md |
| 09-monitoring | qstat/qacct helper | `./monitor.sh help` |
| 10-env | Dump UGE env vars inside a job | `qsub job.sh` |

## Site-specific names (check these first)

Resource and PE names differ between clusters. Find yours with:

```bash
qconf -sql            # queues
qconf -spl            # parallel environments (smp, mpi, orte, ...)
qconf -sc             # complexes (h_vmem, h_rt, gpu, ...)
qconf -sp smp         # details of one PE (allocation_rule matters!)
```

Edit the `#$ -pe`, `#$ -q` and `#$ -l` lines in each `job.sh` to match.

## Notes
- UGE does **not** create log directories; every folder ships with `logs/`.
- `h_vmem` is usually **per slot**: `-pe smp 8 -l h_vmem=2G` = 16G total.
- `#$` lines must come before the first executable command in the script.
