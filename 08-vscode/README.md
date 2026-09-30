# VS Code server as a UGE job

Flow:
1. `submit_vscode.sh <cluster>` submits `vscode_job.sh` using that cluster's settings in `clusters.conf`.
2. The job starts `code-server` bound to 127.0.0.1 on a free port and writes
   `host:port` to `~/.vscode-jobs/<JOB_ID>.endpoint`.
3. `submit_vscode.sh` waits for that file and prints the SSH tunnel command.
4. Open `http://localhost:<local_port>` (password is in the job log / endpoint dir).

Files:
- `clusters.conf`   per-cluster queue / PE / memory names (edit for your 4 clusters)
- `vscode_job.sh`   the job script that runs on the compute node
- `submit_vscode.sh` submit + wait + print tunnel command (run on login node)
- `tunnel.sh`       run on your laptop/JupyterHub side to open the tunnel
- `stop_vscode.sh`  qdel the session and clean up

Requires `code-server` on the compute nodes (e.g. `~/.local/bin/code-server`).
