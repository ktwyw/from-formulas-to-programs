#!/usr/bin/env python3
"""Re-run every example program of the book and compare with the stored output.

Usage (from the repository root):   python3 tools/check_examples.py

For each example the script builds and runs the program in a temporary folder and
compares what it prints with the corresponding ``*.out`` file under ``code/``.
Examples whose compiler or interpreter is not installed are skipped.
Outputs that legitimately differ between runs or machines (timings, memory
addresses) are only checked for running without error.
"""
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CODE = ROOT / "code"
DATA = CODE / "data"
ENV = {k: v for k, v in os.environ.items() if k not in ("JAVA_TOOL_OPTIONS", "_JAVA_OPTIONS")}

# (label, folder, source files, tool needed, shell command, stored output, compare?)
EXAMPLES = []


def add(folder, files, tool, cmd, out, compare=True):
    EXAMPLES.append((f"{folder}/{files[0]}", folder, files, tool, cmd, out, compare))


for name in ("hello", "drag", "newton", "pipe_flow", "read_csv", "scipy_demo", "pandas_demo", "lj_md"):
    add("python", [f"{name}.py"], "python3", f"python3 {name}.py", f"{name}.out")
add("python", ["numpy_speed.py"], "python3", "python3 numpy_speed.py", "numpy_speed.out", compare=False)
for name in ("hello", "drag", "beam_module", "arrays"):
    add("fortran", [f"{name}.f90"], "gfortran", f"gfortran -O2 -o prog {name}.f90 && ./prog", f"{name}.out")
for name in ("hello", "drag"):
    add("c", [f"{name}.c"], "gcc", f"gcc -std=c11 -O2 -o prog {name}.c -lm && ./prog", f"{name}.out")
add("c", ["pointers.c"], "gcc", "gcc -std=c11 -O2 -o prog pointers.c && ./prog", "pointers.out", compare=False)
add("c", ["readstats.c"], "gcc", "gcc -std=c11 -O2 -o prog readstats.c -lm && ./prog", "readstats.out")
for name in ("hello", "drag", "sections", "stl"):
    add("cpp", [f"{name}.cpp"], "g++", f"g++ -std=c++20 -O2 -o prog {name}.cpp && ./prog", f"{name}.out")
for name in ("Hello", "Drag"):
    add("csharp", [f"{name}.cs"], "mcs", f"mcs -out:prog.exe {name}.cs && mono prog.exe", f"{name}.out")
add("csharp", ["Tensile.cs"], "mcs", "mcs -out:prog.exe Tensile.cs && mono prog.exe", "Tensile.out")
for name in ("Hello", "Drag", "Thermal"):
    add("java", [f"{name}.java"], "javac", f"javac {name}.java && java {name}", f"{name}.out")
add("java", ["Streams.java"], "javac", "javac Streams.java && java Streams", "Streams.out")
for name in ("hello", "drag", "arrays"):
    add("javascript", [f"{name}.js"], "node", f"node {name}.js", f"{name}.out")
for name in ("hello", "drag", "matrices"):
    add("matlab", [f"{name}.m"], "octave", f"octave --no-gui --quiet --eval {name}", f"{name}.out")
add("matlab", ["use_function.m", "terminal_velocity.m"], "octave",
    "octave --no-gui --quiet --eval use_function", "use_function.out")
for name in ("hello", "drag", "vectors", "tensile"):
    add("r", [f"{name}.R"], "Rscript", f"Rscript {name}.R", f"{name}.out")
add("rust", ["drag.rs"], "rustc", "rustc -O -o prog drag.rs && ./prog", "drag.out")
add("go", ["drag.go"], "go", "go run drag.go", "drag.out")
add("sql", ["tensile.sql"], "sqlite3", "sqlite3 -header -column :memory: < tensile.sql", "tensile.out")
# Rosetta programs: all must print the three reference lines (see Chapter 15)
ROSETTA = [
    (["rosetta.py"], "python3", "python3 rosetta.py", "rosetta_py.out"),
    (["rosetta.f90"], "gfortran", "gfortran -O2 -o prog rosetta.f90 && ./prog", "rosetta_py.out"),
    (["rosetta.c"], "gcc", "gcc -std=gnu11 -O2 -o prog rosetta.c -lm && ./prog", "rosetta_py.out"),
    (["rosetta.cpp"], "g++", "g++ -std=c++20 -O2 -o prog rosetta.cpp && ./prog", "rosetta_py.out"),
    (["Rosetta.cs"], "mcs", "mcs -out:prog.exe Rosetta.cs && mono prog.exe", "rosetta_cs.out"),
    (["Rosetta.java"], "javac", "javac Rosetta.java && java Rosetta", "rosetta_py.out"),
    (["rosetta.js"], "node", "node rosetta.js", "rosetta_py.out"),
    (["rosetta.m"], "octave", "octave --no-gui --quiet --eval rosetta", "rosetta_py.out"),
    (["rosetta.R"], "Rscript", "Rscript rosetta.R", "rosetta_r.out"),
    (["rosetta.rs"], "rustc", "rustc -O -o prog rosetta.rs && ./prog", "rosetta_py.out"),
    (["rosetta.go"], "go", "go run rosetta.go", "rosetta_py.out"),
    (["rosetta.jl"], "julia", "julia rosetta.jl", "rosetta_jl.out"),
    (["rosetta.wl"], "wolframscript", "wolframscript -file rosetta.wl", "rosetta_wl.out"),
]
for files, tool, cmd, out in ROSETTA:
    add("rosetta", files, tool, cmd, out)
add("julia", ["drag.jl"], "julia", "julia drag.jl", "drag.out")
add("julia", ["sections.jl"], "julia", "julia sections.jl", "sections.out")
# drag.out was produced in a Mathematica notebook; wolframscript lays out TableForm differently,
# so the script only checks that the program runs.
add("wolfram", ["drag.wl"], "wolframscript", "wolframscript -file drag.wl", "drag.out", compare=False)


def run_one(label, folder, files, tool, cmd, out, compare):
    if shutil.which(tool) is None:
        return "SKIP", f"{tool} not installed"
    with tempfile.TemporaryDirectory() as tmp:
        tmp = Path(tmp)
        work = tmp / folder
        work.mkdir()
        for f in files:
            shutil.copy(CODE / folder / f, work)
        shutil.copytree(DATA, tmp / "data")            # programs that read ../data/...
        for f in DATA.iterdir():                       # programs that read ./yield.txt etc.
            shutil.copy(f, work)
        if cmd.endswith("tensile.sql"):
            pass
        res = subprocess.run(cmd, shell=True, cwd=work, env=ENV, capture_output=True, text=True, timeout=600)
        if res.returncode != 0:
            return "FAIL", (res.stderr or res.stdout).strip().splitlines()[-1:]
        if not compare:
            return "RAN", "output varies from run to run; not compared"
        expected = (CODE / folder / out).read_text().rstrip().splitlines()
        got = [l for l in res.stdout.rstrip().splitlines() if not l.startswith("Picked up")]
        if [l.rstrip() for l in got] == [l.rstrip() for l in expected]:
            return "OK", ""
        for g, e in zip(got, expected):
            if g.rstrip() != e.rstrip():
                return "DIFF", f"got {g!r}, stored {e!r}"
        return "DIFF", f"{len(got)} lines printed, {len(expected)} stored"


def main():
    counts = {}
    for ex in EXAMPLES:
        status, note = run_one(*ex)
        counts[status] = counts.get(status, 0) + 1
        print(f"{status:5s} {ex[0]:28s} {note if note else ''}")
    print("\nSummary:", ", ".join(f"{v} {k}" for k, v in sorted(counts.items())))
    sys.exit(1 if counts.get("FAIL", 0) or counts.get("DIFF", 0) else 0)


if __name__ == "__main__":
    main()
