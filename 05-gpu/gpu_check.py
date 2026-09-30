#!/usr/bin/env python3
"""Reports visible GPUs; runs a tiny matmul if PyTorch is available."""
import os, shutil, subprocess

print("CUDA_VISIBLE_DEVICES =", os.environ.get("CUDA_VISIBLE_DEVICES", "<unset>"))
print("SGE_HGR_gpu          =", os.environ.get("SGE_HGR_gpu", "<unset>"))
if shutil.which("nvidia-smi"):
    subprocess.run(["nvidia-smi", "--query-gpu=index,name,memory.total",
                    "--format=csv"], check=False)
try:
    import torch
    if torch.cuda.is_available():
        x = torch.randn(4096, 4096, device="cuda")
        y = (x @ x).sum().item()
        print(f"torch OK on {torch.cuda.get_device_name(0)}; checksum {y:.2f}")
    else:
        print("torch installed but CUDA not available")
except ImportError:
    print("torch not installed; skipped compute test")
