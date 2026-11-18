// Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.function.DoubleUnaryOperator;

public class Rosetta {
    record Result(double root, int iters) {}

    static Result newton(DoubleUnaryOperator f, DoubleUnaryOperator df, double x) {
        for (int k = 1; k <= 50; k++) {
            double step = f.applyAsDouble(x) / df.applyAsDouble(x);
            x -= step;
            if (Math.abs(step) < 1e-12) return new Result(x, k);
        }
        throw new ArithmeticException("no convergence");
    }

    static double trapezoid(DoubleUnaryOperator f, double a, double b, int n) {
        double h = (b - a) / n;
        double s = 0.5 * (f.applyAsDouble(a) + f.applyAsDouble(b));
        for (int i = 1; i < n; i++) s += f.applyAsDouble(a + i * h);
        return s * h;
    }

    public static void main(String[] args) throws IOException {
        Result r = newton(x -> x * x * x - 2 * x - 5, x -> 3 * x * x - 2, 2.0);
        System.out.printf("Newton:     root = %.15f (%d iterations)%n", r.root(), r.iters());
        System.out.printf("Trapezoid:  integral = %.15f (n = 100)%n",
                          trapezoid(Math::sin, 0.0, Math.PI, 100));

        double[] data = Files.readAllLines(Path.of("yield.txt")).stream()
                .filter(s -> !s.isBlank()).mapToDouble(Double::parseDouble).toArray();
        double mean = java.util.Arrays.stream(data).average().orElseThrow();
        double ss = java.util.Arrays.stream(data).map(x -> (x - mean) * (x - mean)).sum();
        System.out.printf("Statistics: n = %d, mean = %.3f, std = %.3f%n",
                          data.length, mean, Math.sqrt(ss / (data.length - 1)));
    }
}
