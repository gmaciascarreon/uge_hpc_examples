#!/usr/bin/env python3
"""Tiny workload: sum of squares, prints where it ran."""
import os, socket, time

n = 10_000_000
start = time.time()
total = sum(i * i for i in range(n))
print(f"host={socket.gethostname()} job={os.environ.get('JOB_ID')}")
print(f"sum of squares below {n}: {total}")
print(f"elapsed: {time.time() - start:.2f}s")
