# Falling object with quadratic air drag, explicit Euler method.
m <- 80.0; c <- 0.25; g <- 9.81       # SI units
dt <- 0.5; t_end <- 20.0

acceleration <- function(v) g - (c / m) * v^2
vt <- sqrt(m * g / c)
exact_speed <- function(t) vt * tanh(g * t / vt)

t <- seq(0, t_end, by = dt)           # 0, 0.5, ..., 20
v <- numeric(length(t))               # vector of zeros
for (n in seq_len(length(t) - 1)) {   # n = 1, 2, ..., 40 (R indices start at 1)
  v[n + 1] <- v[n] + dt * acceleration(v[n])
}

idx <- seq(1, length(t), by = 4)
ve <- exact_speed(t[idx])             # vectorised
cat(sprintf("%6s %10s %10s %10s\n", "t (s)", "v_Euler", "v_exact", "error"))
cat(sprintf("%6.1f %10.4f %10.4f %10.2e\n", t[idx], v[idx], ve, v[idx] - ve), sep = "")
cat(sprintf("Terminal velocity: %.4f m/s\n", vt))
