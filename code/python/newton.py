"""Newton's method for f(x) = x^3 - 2x - 5 = 0 (the classic test problem)."""


def f(x):
    return x**3 - 2.0 * x - 5.0


def dfdx(x):
    return 3.0 * x**2 - 2.0


def newton(f, dfdx, x0, tol=1e-12, max_iter=50):
    """Return a root of f near x0 and the number of iterations used."""
    x = x0
    for k in range(1, max_iter + 1):
        step = f(x) / dfdx(x)
        x = x - step
        print(f"  iteration {k}: x = {x:.15f}, |step| = {abs(step):.2e}")
        if abs(step) < tol:
            return x, k
    raise RuntimeError("Newton's method did not converge")


root, iterations = newton(f, dfdx, x0=2.0)
print(f"Root: {root:.15f} after {iterations} iterations")
print(f"Check: f(root) = {f(root):.2e}")
