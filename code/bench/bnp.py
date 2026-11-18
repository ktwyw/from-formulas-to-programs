import numpy as np, time
n = 10_000_000
t0 = time.perf_counter(); x = np.linspace(0.0, np.pi, n + 1); y = np.sin(x)
s = (np.pi / n) * (y.sum() - 0.5 * (y[0] + y[-1]))
print(f"{time.perf_counter() - t0:.4f} {s:.12f}")
