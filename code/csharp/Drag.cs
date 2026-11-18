// Falling object with quadratic air drag, explicit Euler method.
using System;

class Drag
{
    const double M = 80.0, C = 0.25, G = 9.81;   // SI units
    const double Dt = 0.5, TEnd = 20.0;

    static double Acceleration(double v) => G - (C / M) * v * v;

    static double ExactSpeed(double t)
    {
        double vt = Math.Sqrt(M * G / C);
        return vt * Math.Tanh(G * t / vt);
    }

    static void Main()
    {
        int nSteps = (int)Math.Round(TEnd / Dt);
        double[] t = new double[nSteps + 1];     // arrays start filled with 0.0
        double[] v = new double[nSteps + 1];

        for (int n = 0; n < nSteps; n++)
        {
            v[n + 1] = v[n] + Dt * Acceleration(v[n]);
            t[n + 1] = (n + 1) * Dt;
        }

        Console.WriteLine($"{"t (s)",6} {"v_Euler",10} {"v_exact",10} {"error",10}");
        for (int n = 0; n <= nSteps; n += 4)
        {
            double ve = ExactSpeed(t[n]);
            Console.WriteLine($"{t[n],6:F1} {v[n],10:F4} {ve,10:F4} {v[n] - ve,10:0.00e+00}");
        }
        Console.WriteLine($"Terminal velocity: {Math.Sqrt(M * G / C):F4} m/s");
    }
}
