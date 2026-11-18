(* Three small numerical tasks: Newton's method, trapezoidal rule, statistics. *)
newton[f_, df_, x0_, tol_ : 10.^-12] := Module[{x = x0, step, k = 0},
  While[True,
    k++; step = f[x]/df[x]; x -= step;
    If[Abs[step] < tol || k >= 50, Break[]]];
  If[Abs[step] >= tol, Print["no convergence"]; Abort[]];
  {x, k}]

trapezoid[f_, a_, b_, n_] := With[{h = (b - a)/n},
  h (Total[f /@ (a + h Range[1, n - 1])] + (f[a] + f[b])/2)]

(* fixed number of decimals, keeping trailing zeros: 276.850, not 276.85 *)
fmt[x_, d_] := NumberForm[x, d, NumberPadding -> {"", "0"}]

{root, iters} = newton[#^3 - 2 # - 5 &, 3 #^2 - 2 &, 2.];
Print["Newton:     root = ", fmt[root, {16, 15}], " (", iters, " iterations)"]
Print["Trapezoid:  integral = ", fmt[trapezoid[Sin, 0., N[Pi], 100], {16, 15}], " (n = 100)"]

(* read yield.txt from the folder of this file, as a script or in a notebook *)
here = If[$InputFileName =!= "", DirectoryName[$InputFileName],
          Quiet[Check[NotebookDirectory[], Directory[]]]];
data = ReadList[FileNameJoin[{here, "yield.txt"}], Number];
If[data === $Failed, Print["Cannot open yield.txt in ", here]; Abort[]];
Print["Statistics: n = ", Length[data], ", mean = ", fmt[Mean[data], {6, 3}],
      ", std = ", fmt[StandardDeviation[data], {5, 3}]]
