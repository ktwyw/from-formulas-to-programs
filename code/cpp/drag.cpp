// Falling object with quadratic air drag, explicit Euler method.
#include <cmath>
#include <cstdio>
#include <vector>

int main()
{
    const double m = 80.0, c = 0.25, g = 9.81;   // SI units
    const double dt = 0.5, t_end = 20.0;
    const int n_steps = static_cast<int>(std::round(t_end / dt));

    // A lambda: an unnamed function that "captures" m, c and g
    auto acceleration = [=](double v) { return g - (c / m) * v * v; };
    const double vt = std::sqrt(m * g / c);
    auto exact_speed = [=](double t) { return vt * std::tanh(g * t / vt); };

    std::vector<double> t(n_steps + 1, 0.0), v(n_steps + 1, 0.0);
    for (int n = 0; n < n_steps; ++n) {
        v[n + 1] = v[n] + dt * acceleration(v[n]);
        t[n + 1] = (n + 1) * dt;
    }

    std::printf("%6s %10s %10s %10s\n", "t (s)", "v_Euler", "v_exact", "error");
    for (int n = 0; n <= n_steps; n += 4) {
        const double ve = exact_speed(t[n]);
        std::printf("%6.1f %10.4f %10.4f %10.2e\n", t[n], v[n], ve, v[n] - ve);
    }
    std::printf("Terminal velocity: %.4f m/s\n", vt);
}
