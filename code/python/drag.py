"""Falling object with quadratic air drag, solved with the explicit Euler method.

    m dv/dt = m g - c v^2,   v(0) = 0
Exact solution: v(t) = vt * tanh(g t / vt),  vt = sqrt(m g / c)
"""
import math

# Parameters (SI units)
m = 80.0        # mass, kg
c = 0.25        # drag coefficient, kg/m
g = 9.81        # gravitational acceleration, m/s^2
dt = 0.5        # time step, s
t_end = 20.0    # final time, s


def acceleration(v):
    """Right-hand side of the ODE: dv/dt = g - (c/m) v^2."""
    return g - (c / m) * v**2


def exact_speed(t):
    """Exact solution of the drag equation."""
    vt = math.sqrt(m * g / c)
    return vt * math.tanh(g * t / vt)


# Time stepping
n_steps = round(t_end / dt)
t = [0.0] * (n_steps + 1)
v = [0.0] * (n_steps + 1)
for n in range(n_steps):
    v[n + 1] = v[n] + dt * acceleration(v[n])
    t[n + 1] = (n + 1) * dt

# Output: every 4th step (every 2 s)
print(f"{'t (s)':>6} {'v_Euler':>10} {'v_exact':>10} {'error':>10}")
for n in range(0, n_steps + 1, 4):
    ve = exact_speed(t[n])
    print(f"{t[n]:6.1f} {v[n]:10.4f} {ve:10.4f} {v[n] - ve:10.2e}")
print(f"Terminal velocity: {math.sqrt(m * g / c):.4f} m/s")
