"""Three SciPy tools every engineer uses: root finding, integration, ODEs."""
import numpy as np
from scipy.optimize import brentq
from scipy.integrate import quad, solve_ivp

# 1. Root finding: the same cubic as in newton.py
root = brentq(lambda x: x**3 - 2*x - 5, 2.0, 3.0)
print(f"brentq root         : {root:.15f}")

# 2. Numerical integration: integral of sin(x) from 0 to pi (exact: 2)
value, abs_err = quad(np.sin, 0.0, np.pi)
print(f"quad integral       : {value:.15f} (error estimate {abs_err:.1e})")

# 3. ODE: the drag problem, solved with an adaptive Runge-Kutta method
m, c, g = 80.0, 0.25, 9.81
sol = solve_ivp(lambda t, v: g - c / m * v**2, (0.0, 20.0), [0.0],
                rtol=1e-10, atol=1e-10, t_eval=[10.0, 20.0])
vt = np.sqrt(m * g / c)
for t, v in zip(sol.t, sol.y[0]):
    print(f"solve_ivp v({t:4.1f})  : {v:.6f}  exact {vt*np.tanh(g*t/vt):.6f}")
