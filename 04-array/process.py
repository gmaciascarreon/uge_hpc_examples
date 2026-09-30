#!/usr/bin/env python3
"""Reads a file of integers and writes basic stats."""
import sys, statistics

path = sys.argv[1]
with open(path) as f:
    nums = [int(x) for x in f if x.strip()]
print(f"file={path} n={len(nums)} min={min(nums)} max={max(nums)} "
      f"mean={statistics.mean(nums):.2f} median={statistics.median(nums)}")
