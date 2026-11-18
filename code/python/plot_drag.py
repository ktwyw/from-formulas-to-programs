"""Plot the Euler solution of the drag problem against the exact solution."""
import numpy as np
import matplotlib.pyplot as plt

plt.rcParams.update({"font.family": "serif", "font.serif": ["TeX Gyre Pagella", "Palatino", "DejaVu Serif"],
                     "mathtext.fontset": "cm", "font.size": 11})

m, c, g = 80.0, 0.25, 9.81
dt, t_end = 0.5, 20.0
vt = np.sqrt(m * g / c)

# Euler method
t = np.arange(0.0, t_end + dt / 2, dt)
v = np.zeros_like(t)
for n in range(len(t) - 1):
    v[n + 1] = v[n] + dt * (g - c / m * v[n] ** 2)

# Exact solution on a fine grid
tf = np.linspace(0.0, t_end, 400)
vf = vt * np.tanh(g * tf / vt)

fig, ax = plt.subplots(figsize=(5.8, 3.9))
ax.plot(tf, vf, "-", color="#12497a", lw=1.8, label="exact")
ax.plot(t, v, "o", ms=4.5, mfc="white", mec="#c8922a", mew=1.4,
        label=r"Euler, $\Delta t = 0.5$ s")
ax.axhline(vt, ls="--", color="gray", lw=1, label=r"terminal velocity $v_\mathrm{t}$")
ax.set_xlabel("time $t$ (s)")
ax.set_ylabel("speed $v$ (m/s)")
ax.set_xlim(0, t_end)
ax.set_ylim(0, 62)
ax.tick_params(direction="in", top=True, right=True)   # axes boxed on all sides
ax.legend(frameon=False, loc="lower right")
fig.tight_layout()
fig.savefig("drag_euler.pdf")
print("saved drag_euler.pdf")
