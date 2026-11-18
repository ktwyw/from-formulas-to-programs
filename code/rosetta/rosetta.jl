# Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
using Printf, Statistics

function newton(f, df, x; tol=1e-12, max_iter=50)
    for k in 1:max_iter
        step = f(x) / df(x)
        x -= step
        abs(step) < tol && return x, k      # "a && b": do b only if a is true
    end
    error("no convergence")
end

function trapezoid(f, a, b, n)
    h = (b - a) / n
    s = (f(a) + f(b)) / 2
    for i in 1:n-1
        s += f(a + i * h)
    end
    return s * h
end

root, iters = newton(x -> x^3 - 2x - 5, x -> 3x^2 - 2, 2.0)
@printf("Newton:     root = %.15f (%d iterations)\n", root, iters)
@printf("Trapezoid:  integral = %.15f (n = 100)\n", trapezoid(sin, 0.0, π, 100))

data = parse.(Float64, filter(!isempty, strip.(readlines("yield.txt"))))
@printf("Statistics: n = %d, mean = %.3f, std = %.3f\n", length(data), mean(data), std(data))
