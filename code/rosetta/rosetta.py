"""Three small numerical tasks: Newton's method, trapezoidal rule, statistics."""
import math


def newton(f, df, x, tol=1e-12, max_iter=50):
    for k in range(1, max_iter + 1):
        step = f(x) / df(x)
        x -= step
        if abs(step) < tol:
            return x, k
    raise RuntimeError("no convergence")


def trapezoid(f, a, b, n):
    h = (b - a) / n
    s = 0.5 * (f(a) + f(b))
    for i in range(1, n):
        s += f(a + i * h)
    return s * h


def mean_std(x):
    n = len(x)
    mean = sum(x) / n
    var = sum((xi - mean) ** 2 for xi in x) / (n - 1)
    return mean, math.sqrt(var)


root, iters = newton(lambda x: x**3 - 2*x - 5, lambda x: 3*x**2 - 2, 2.0)
print(f"Newton:     root = {root:.15f} ({iters} iterations)")
print(f"Trapezoid:  integral = {trapezoid(math.sin, 0.0, math.pi, 100):.15f} (n = 100)")
with open("yield.txt") as f:
    data = [float(line) for line in f if line.strip()]
m, s = mean_std(data)
print(f"Statistics: n = {len(data)}, mean = {m:.3f}, std = {s:.3f}")
