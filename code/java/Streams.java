// Reading a file and computing statistics with the Stream API.
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.DoubleSummaryStatistics;
import java.util.List;

public class Streams {
    public static void main(String[] args) throws IOException {
        Path path = Path.of(args.length > 0 ? args[0] : "../data/yield.txt");
        List<Double> values = Files.readAllLines(path).stream()
                .map(String::trim)
                .filter(line -> !line.isEmpty())
                .map(Double::parseDouble)
                .toList();

        DoubleSummaryStatistics s = values.stream()
                .mapToDouble(Double::doubleValue)
                .summaryStatistics();
        double mean = s.getAverage();
        double var = values.stream()
                .mapToDouble(x -> (x - mean) * (x - mean))
                .sum() / (s.getCount() - 1);

        System.out.printf("n = %d, mean = %.2f MPa, std = %.2f MPa%n",
                s.getCount(), mean, Math.sqrt(var));
        System.out.printf("min = %.1f MPa, max = %.1f MPa%n", s.getMin(), s.getMax());
        long above = values.stream().filter(x -> x > 275.0).count();
        System.out.println(above + " of " + values.size() + " specimens exceed 275 MPa");
    }
}
