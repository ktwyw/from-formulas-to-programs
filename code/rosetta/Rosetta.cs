// Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
using System;
using System.IO;
using System.Linq;

class Rosetta
{
    static (double root, int iters) Newton(Func<double, double> f, Func<double, double> df, double x)
    {
        for (int k = 1; k <= 50; k++)
        {
            double step = f(x) / df(x);
            x -= step;
            if (Math.Abs(step) < 1e-12) return (x, k);
        }
        throw new Exception("no convergence");
    }

    static double Trapezoid(Func<double, double> f, double a, double b, int n)
    {
        double h = (b - a) / n;
        double s = 0.5 * (f(a) + f(b));
        for (int i = 1; i < n; i++) s += f(a + i * h);
        return s * h;
    }

    static void Main()
    {
        var (root, iters) = Newton(x => x * x * x - 2 * x - 5, x => 3 * x * x - 2, 2.0);
        Console.WriteLine($"Newton:     root = {root:F15} ({iters} iterations)");
        Console.WriteLine($"Trapezoid:  integral = {Trapezoid(Math.Sin, 0.0, Math.PI, 100):F15} (n = 100)");

        double[] data = File.ReadLines("yield.txt")
                            .Where(line => line.Trim().Length > 0)
                            .Select(double.Parse).ToArray();
        double mean = data.Average();
        double std = Math.Sqrt(data.Sum(x => (x - mean) * (x - mean)) / (data.Length - 1));
        Console.WriteLine($"Statistics: n = {data.Length}, mean = {mean:F3}, std = {std:F3}");
    }
}
