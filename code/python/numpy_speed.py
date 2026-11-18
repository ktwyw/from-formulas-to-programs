"""Compare a pure-Python loop with a vectorised NumPy expression."""
import time
import numpy as np

n = 1_000_000
x = np.linspace(0.0, 10.0, n)

# 1. Pure Python loop over a list
xs = list(x)
start = time.perf_counter()
y_loop = [0.0] * n
for i in range(n):
    y_loop[i] = 3.0 * xs[i] ** 2 + 2.0 * xs[i] + 1.0
t_loop = time.perf_counter() - start

# 2. Vectorised NumPy
start = time.perf_counter()
y_vec = 3.0 * x**2 + 2.0 * x + 1.0
t_vec = time.perf_counter() - start

print(f"Python loop : {t_loop*1000:8.1f} ms")
print(f"NumPy       : {t_vec*1000:8.1f} ms")
print(f"Speed-up    : {t_loop/t_vec:8.0f} x")
print("Same result :", np.allclose(y_loop, y_vec))
