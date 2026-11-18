# Changelog

## 1.0.1 (18 November 2026)

First version shared with students. It includes all corrections from the review of version 1.0.0; the full list is in `ERRATA.md`.

- Code set outside listings no longer shows font ligatures or curly quotes.
- All programs that read a data file now look in `../data/`.
- Safer order of tests in the Structured Text tank controller; `fixed = true` in the Modelica model.
- `rosetta.c`, `rosetta.m` and `rosetta.wl` now report non-convergence; `rosetta.wl` keeps trailing zeros.
- `drag.wl` prints its table when run as a script; both tolerances set in the Julia ODE example.
- Exercise 8.3 gives the constants to use; overlapping labels in Figure 1.3 separated.
- Reference-guide tables renumbered R1 and R2; Table R2 set as a landscape page so that it is readable.
- Answer 3.8 describes what actually happens with a large time step (the run ends in `nan`).
- Orientation note under the opening question of Chapters 4–14; a short reading path and a pointer to WSL for Windows users in "How to Use These Notes".
- Two-paragraph explanation of the broadcasting line in the molecular dynamics example (Section 3.17).
- Straight quotes restored in Table R2; curly quotes restored in the caption of the syntax table (Chapter 15).
- Subject index: common-noun entries in lower case.
- `drag.wl` run in Mathematica: output stored in `code/wolfram/drag.out` and printed in Section 11.7; it agrees with the other languages to the six digits shown.
- `drag.jl` run in Julia 1.13: output identical to Python's, stored in `code/julia/drag.out` and printed in Section 13.4.
- `rosetta.wl` now finds `yield.txt` in its own folder when run in a notebook, and stops with a message if it cannot; Section 15.4 explains why R and the Wolfram Language print …443 for the trapezoidal rule.
- `rosetta.wl` run in Mathematica after the fix; output stored in `code/rosetta/rosetta_wl.out`.
- `sections.jl` run in Julia 1.13; output stored in `code/julia/sections.out` and printed in Section 13.6.
- `rosetta.jl` run in Julia 1.13; output identical to Python's, stored in `code/rosetta/rosetta_jl.out`. Every complete program in the book has now been run.
- The book is now 216 pages (208 numbered); `code/` holds 51 stored outputs (46 in 1.0.0, plus the five Julia and Mathematica runs).

## 1.0.0 (18 November 2026)

Review copy, checked before release; it was not distributed to students.

- Book of 16 chapters, an epilogue, four reference guides and answers to selected exercises (212 pages).
- 83 program files under `code/`, with 46 stored outputs from real runs.
- `tools/check_examples.py` re-runs every example and compares it with the stored output.
- One executed companion notebook, `notebooks/running_example.ipynb`.
