# Errata and notes — *From Formulas to Programs*

**Author:** Yanwei Wang, Nazarbayev University

Version 1.0.0 was a review copy read before release. This file records the corrections
made after that review. **All of them are included in version 1.0.1**, the PDF and the code
now in this repository, so students do not need to apply anything below; page numbers
refer to the review copy. Corrections found during the course will be added here, with
the page numbers of the current PDF. Thank you to everyone who sends corrections.

## 1. Characters changed by the typesetting

In a few tables and sentences the font replaced doubled characters or straight quotes in
code by typographic symbols. Code must always be typed with plain ASCII characters.

| Page | Location | Printed in 1.0.0 | Correct |
| :--- | :--- | :--- | :--- |
| 10 | Table 1.1 (C++) | `std::cout « "Hello, world!\n";` | `std::cout << "Hello, world!\n";` |
| 10 | Table 1.1 (MATLAB, SQL) | curly quotes `’Hello, world!’` | straight quotes `'Hello, world!'` |
| 29 | Section 3.2 | prompt shown as `»>` | `>>>` |
| 80 | Section 6.2 | insertion operator `«` | `<<` |
| 157 | Section 14.12 (Dart) | curly quotes | straight quotes `'Hello, world!'` |
| 190 | Installation guide | `wsl –install` | `wsl --install` (two hyphens) |

The dashes that stood for "not applicable" in three tables now read "n/a".

## 2. Where the programs look for the data files

The data files `tensile.csv` and `yield.txt` are in `code/data/`.

- From version 1.0.1 every program that reads a data file looks for it in `../data/`, so
  run each program from inside its own language folder. In 1.0.0, `c/readstats.c`,
  `csharp/Tensile.cs`, `java/Streams.java` and `r/tensile.R` looked in the current folder
  instead.
- The programs in `code/rosetta/` read `yield.txt` from the current folder. A copy of the
  file is kept in `code/rosetta/`, so they run there without changes.

## 3. Corrections by chapter

**Chapter 1, Figure 1.3.** The labels "Mathematica" and "C#" overlapped on the timeline.

**Chapter 8, Exercise 8.3.** The exercise now gives the values to use: the
Stefan–Boltzmann constant σ = 5.67 × 10⁻⁸ W/(m² K⁴) and an emissivity ε = 0.9. The mean
temperature must be in kelvin before it is cubed.

**Chapter 11, Section 11.7 (`drag.wl`).** `TableForm[...]` is displayed in a notebook but
prints nothing when the file is run with `wolframscript`. The line is now wrapped in
`Print[...]`.

**Chapter 13, Section 13.7.** The call to `solve` now sets both tolerances,
`reltol=1e-10, abstol=1e-10`. With only `reltol`, the default absolute tolerance of
`1e-6` limits the accuracy.

**Chapter 14, Section 14.6 (`TankControl`).** The Structured Text now tests the stop
conditions first:

```
IF EmergencyStop OR LevelHigh THEN
    Pump := FALSE;
ELSIF LevelLow THEN
    Pump := TRUE;
END_IF;
```

In 1.0.0 the low-level switch was tested before the high-level switch, so a low-level
switch stuck at `TRUE` would have kept the pump running at a full tank. The ladder rung
described in the text was already correct.

**Chapter 14, Section 14.8 (`FallingBody`).** The two state variables are now declared
with `fixed = true`, which makes the start values firm initial conditions.

**Chapter 15, `newton` when it does not converge.** Three of the thirteen programs did not
stop with an error: `rosetta.c` (the caller now tests for the returned `-1`), `rosetta.m`
and `rosetta.wl` (both now stop with a message).

**Chapter 15, `rosetta.wl`.** `NumberForm` drops trailing zeros by default, so the mean was
printed as `276.85`. The program now sets `NumberPadding -> {"", "0"}` and prints
`276.850` like the others.

**Chapter 15, Figure 15.1.** The text now says why Julia is missing from the speed
comparison (it was not installed on the computer used) and that C# was timed with the old
Mono runtime, not with current .NET.

**Back matter.** The tables of the reference guides are now numbered R1 and R2; in 1.0.0
they carried Chapter 16 numbers. Table R2 (numerical functions) was printed too small to
read and is now a landscape page. The answer to Exercise 3.8 now says that with a time
step of 0.05 the simulation ends in `nan`.

**Table 15.1 and Table R2.** The caption of the syntax table showed two straight
apostrophes in place of a closing quotation mark, and the MATLAB and Julia transpose
`A'` in Table R2 was printed with a curly apostrophe. Both are corrected.

**Reading aids added in 1.0.1.** "How to Use These Notes" now gives a short reading path
and tells Windows users where to find WSL and browser options; Chapters 4–14 carry a note
that they are orientation chapters; Section 3.17 explains the broadcasting line of the
molecular dynamics program.

**Chapter 15, `rosetta.wl` reading its data file.** Run from a Mathematica notebook, the
program looked for `yield.txt` in Mathematica's working folder, not in the folder of the
file, and printed a statistics line containing `$Failed`. It now looks in its own folder
and stops with a message if the file is missing.

**Chapter 15, Section 15.4.** The explanation of why R prints `1.999835503887443` for the
trapezoidal rule is extended: the Wolfram Language prints the same value, and it is the
exactly rounded sum of the terms.

## What has been run

Every complete program in the book has now been run. The Wolfram Language programs were
run in Mathematica and the Julia programs in Julia 1.13; they agree with the other
languages, and their outputs are stored beside them as `.out` files. Only the short
fragments in `code/others/`, which need special tools (a PLC environment, an HDL simulator,
OpenModelica, Excel), were checked by hand. Please report any error to yanwei.wang@nu.edu.kz.
