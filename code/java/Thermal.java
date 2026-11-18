// Interfaces and polymorphism: thermal resistances in series (a composite wall).
import java.util.List;

interface ThermalResistance {
    double resistance();          // K/W
    String describe();
}

record ConductionLayer(String material, double thickness, double k, double area)
        implements ThermalResistance {
    public double resistance() { return thickness / (k * area); }
    public String describe() {
        return String.format("%-12s L = %.3f m, k = %5.3f W/(m K)", material, thickness, k);
    }
}

record Convection(String side, double h, double area) implements ThermalResistance {
    public double resistance() { return 1.0 / (h * area); }
    public String describe() {
        return String.format("%-12s h = %.1f W/(m^2 K)", "convection " + side, h);
    }
}

public class Thermal {
    public static void main(String[] args) {
        double A = 10.0;   // wall area, m^2
        List<ThermalResistance> wall = List.of(
            new Convection("in", 8.0, A),
            new ConductionLayer("plaster", 0.015, 0.50, A),
            new ConductionLayer("brick", 0.250, 0.72, A),
            new ConductionLayer("insulation", 0.100, 0.035, A),
            new Convection("out", 25.0, A));

        double total = 0.0;
        for (ThermalResistance r : wall) {
            total += r.resistance();
            System.out.printf("%-45s R = %.5f K/W%n", r.describe(), r.resistance());
        }
        double dT = 20.0 - (-25.0);   // inside 20 C, outside -25 C (an Astana winter)
        System.out.printf("Total R = %.4f K/W, U = %.3f W/(m^2 K)%n", total, 1.0 / (total * A));
        System.out.printf("Heat loss through %.0f m^2 of wall: %.1f W%n", A, dT / total);
    }
}
