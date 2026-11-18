(* Falling object with quadratic drag: explicit Euler method *)
m = 80.; c = 0.25; g = 9.81; dt = 0.5; tEnd = 20.;
nSteps = Round[tEnd/dt];
vt = Sqrt[m g/c];

eulerStep[v_] := v + dt (g - c/m v^2);
vEuler = NestList[eulerStep, 0., nSteps];   (* {v0, v1, ..., v40} *)
times  = Range[0., tEnd, dt];
vExact = vt Tanh[g times/vt];               (* listable: works on the whole list *)

table = Transpose[{times, vEuler, vExact, vEuler - vExact}][[1 ;; -1 ;; 4]];
Print[TableForm[table, TableHeadings -> {None, {"t (s)", "v_Euler", "v_exact", "error"}}]]
Print["Terminal velocity: ", NumberForm[vt, {6, 4}], " m/s"]
