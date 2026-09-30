#!/bin/bash
# Creates 20 sample input files and inputs.txt (one path per line).
set -e
mkdir -p data
: > inputs.txt
for i in $(seq 1 20); do
    f="data/sample_${i}.txt"
    shuf -i 1-1000 -n 500 > "$f"
    echo "$f" >> inputs.txt
done
echo "Created $(wc -l < inputs.txt) inputs. Adjust '#$ -t' in job.sh if needed."
