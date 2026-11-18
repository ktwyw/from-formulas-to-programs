// Falling object with quadratic air drag, explicit Euler method.
public class Drag {
    static final double M = 80.0, C = 0.25, G = 9.81;   // SI units
    static final double DT = 0.5, T_END = 20.0;

    static double acceleration(double v) {
        return G - (C / M) * v * v;
    }

    static double exactSpeed(double t) {
        double vt = Math.sqrt(M * G / C);
        return vt * Math.tanh(G * t / vt);
    }

    public static void main(String[] args) {
        int nSteps = (int) Math.round(T_END / DT);
        double[] t = new double[nSteps + 1];
        double[] v = new double[nSteps + 1];

        for (int n = 0; n < nSteps; n++) {
            v[n + 1] = v[n] + DT * acceleration(v[n]);
            t[n + 1] = (n + 1) * DT;
        }

        System.out.printf("%6s %10s %10s %10s%n", "t (s)", "v_Euler", "v_exact", "error");
        for (int n = 0; n <= nSteps; n += 4) {
            double ve = exactSpeed(t[n]);
            System.out.printf("%6.1f %10.4f %10.4f %10.2e%n", t[n], v[n], ve, v[n] - ve);
        }
        System.out.printf("Terminal velocity: %.4f m/s%n", Math.sqrt(M * G / C));
    }
}
