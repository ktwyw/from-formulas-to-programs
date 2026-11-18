// Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
#include <cmath>
#include <fstream>
#include <functional>
#include <iostream>
#include <numbers>
#include <numeric>
#include <format>       // C++20
#include <stdexcept>
#include <utility>
#include <vector>

using Func = std::function<double(double)>;

std::pair<double, int> newton(const Func& f, const Func& df, double x)
{
    for (int k = 1; k <= 50; ++k) {
        const double step = f(x) / df(x);
        x -= step;
        if (std::abs(step) < 1e-12) return {x, k};
    }
    throw std::runtime_error("no convergence");
}

double trapezoid(const Func& f, double a, double b, int n)
{
    const double h = (b - a) / n;
    double s = 0.5 * (f(a) + f(b));
    for (int i = 1; i < n; ++i) s += f(a + i * h);
    return s * h;
}

int main()
{
    auto [root, iters] = newton([](double x) { return x * x * x - 2 * x - 5; },
                                [](double x) { return 3 * x * x - 2; }, 2.0);
    std::cout << std::format("Newton:     root = {:.15f} ({} iterations)", root, iters) << '\n';
    std::cout << std::format("Trapezoid:  integral = {:.15f} (n = 100)",
                 trapezoid([](double x) { return std::sin(x); }, 0.0, std::numbers::pi, 100)) << '\n';

    std::ifstream in("yield.txt");
    std::vector<double> data;
    for (double v; in >> v;) data.push_back(v);
    const double n = static_cast<double>(data.size());
    const double mean = std::accumulate(data.begin(), data.end(), 0.0) / n;
    double ss = 0.0;
    for (double v : data) ss += (v - mean) * (v - mean);
    std::cout << std::format("Statistics: n = {}, mean = {:.3f}, std = {:.3f}", data.size(), mean,
                 std::sqrt(ss / (n - 1))) << '\n';
}
