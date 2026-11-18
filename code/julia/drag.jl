# Falling object with quadratic air drag, explicit Euler method.
using Printf

const m, c, g = 80.0, 0.25, 9.81      # SI units
const dt, t_end = 0.5, 20.0

acceleration(v) = g - (c / m) * v^2   # one-line function definition
const vt = sqrt(m * g / c)
exact_speed(t) = vt * tanh(g * t / vt)

function euler(f, v0, dt, n_steps)
    v = zeros(n_steps + 1)            # Vector{Float64}, indices 1 ... n_steps+1
    v[1] = v0
    for n in 1:n_steps
        v[n+1] = v[n] + dt * f(v[n])
    end
    return v
end

t = 0:dt:t_end                        # a range, end included
v = euler(acceleration, 0.0, dt, length(t) - 1)
ve = exact_speed.(t)                  # the dot applies the function element-wise

@printf("%6s %10s %10s %10s\n", "t (s)", "v_Euler", "v_exact", "error")
for n in 1:4:length(t)
    @printf("%6.1f %10.4f %10.4f %10.2e\n", t[n], v[n], ve[n], v[n] - ve[n])
end
@printf("Terminal velocity: %.4f m/s\n", vt)
