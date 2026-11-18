# Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
newton <- function(f, df, x, tol = 1e-12, max_iter = 50) {
  for (k in 1:max_iter) {
    step <- f(x) / df(x)
    x <- x - step
    if (abs(step) < tol) return(list(root = x, iters = k))
  }
  stop("no convergence")
}

trapezoid <- function(f, a, b, n) {
  x <- seq(a, b, length.out = n + 1)
  y <- f(x)
  (b - a) / n * (sum(y) - (y[1] + y[n + 1]) / 2)
}

r <- newton(function(x) x^3 - 2*x - 5, function(x) 3*x^2 - 2, 2.0)
cat(sprintf("Newton:     root = %.15f (%d iterations)\n", r$root, r$iters))
cat(sprintf("Trapezoid:  integral = %.15f (n = 100)\n", trapezoid(sin, 0, pi, 100)))

data <- scan("yield.txt", quiet = TRUE)
cat(sprintf("Statistics: n = %d, mean = %.3f, std = %.3f\n", length(data), mean(data), sd(data)))
