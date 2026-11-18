#!/usr/bin/env bash
# Run a simulation for several parameter values and collect the results.
set -euo pipefail                 # stop on errors and undefined variables

mkdir -p results
for c in 0.15 0.25 0.35; do
    out="results/drag_c${c}.txt"
    # Replace the drag coefficient in a copy of the program and run it
    sed "s/^c = 0.25 /c = ${c} /" ../python/drag.py > /tmp/drag_case.py
    python3 /tmp/drag_case.py > "$out"
    vt=$(grep "Terminal" "$out" | awk '{print $3}')
    echo "c = ${c} kg/m  ->  terminal velocity ${vt} m/s  (saved in ${out})"
done
echo "Number of result files: $(ls results | wc -l)"
